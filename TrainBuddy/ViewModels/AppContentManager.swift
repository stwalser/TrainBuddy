//
//  ConnectionManager.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation

enum ConnectionState {
    case Starting
    case WrongWifi
    case CorrectWifi
    case Fetching
    case Error
}

@Observable
class AppContentManager {
    @ObservationIgnored let refreshInterval = 30.0
    @ObservationIgnored let reconnectInterval = 0.5
    @ObservationIgnored let trainWifiManager = TrainWiFiManager()
    @ObservationIgnored var company: Company?
    @ObservationIgnored var trainCommunicator: TrainCommunicator?
    @ObservationIgnored var refreshTimer = Timer()
    @ObservationIgnored var reconnectTimer = Timer()

    var connectionState: ConnectionState = .Starting
    var trainState: TrainState?
    
    func startReconnectTimer() {
        self.reconnectTimer = Timer.scheduledTimer(withTimeInterval: self.reconnectInterval, repeats: true) { _ in
            switch self.connectionState {
            case .Starting:
                Task {
                    await self.checkWifiState()
                }
            case .WrongWifi:
                Task {
                    await self.checkWifiState()
                    self.trainState = nil
                }
            case .CorrectWifi:
                Task {
                    do {
                        let state = try await self.trainCommunicator!.fetchCombinedState()
                        self.trainState = TrainState(for: self.company!, state: state)
                        self.connectionState = .Fetching
                        self.addLiveActivity()
                    } catch {
                        print(error)
                        self.connectionState = .Error
                    }
                }
            case .Fetching:
                break
            case .Error:
                Task {
                    await self.checkWifiState()
                }
            }
        }
    }
    
    func startRefreshTimer() {
        self.refreshTimer =  Timer.scheduledTimer(withTimeInterval: self.refreshInterval, repeats: true) { _ in
            switch self.connectionState {
            case .Starting:
                break
            case .WrongWifi:
                break
            case .CorrectWifi:
                break
            case .Fetching:
                Task {
                    do {
                        await self.trainState!.update(try await self.trainCommunicator!.fetchCombinedState())
                    } catch {
                        print(error)
                        
                        self.connectionState = .Error
                    }
                }
            case .Error:
                break
            }
        }
    }
    
    func triggerTimers() {
        startReconnectTimer()
        startRefreshTimer()
    }
    
    func addLiveActivity() {
        Task {
            if let trainState = self.trainState {
                await trainState.startLiveActivity()
            }
        }
    }
    
    func removeLiveActivity() {
        Task {
            if let trainState = self.trainState {
                await trainState.stopLiveActivity()
            }
        }
    }
        
    private func checkWifiState() async {
#if targetEnvironment(simulator)
        self.company = .OEBB
        self.trainCommunicator = TrainCommunicator(for: .OEBB)
        self.connectionState = .CorrectWifi
#else
        if let company = await self.trainWifiManager.getTrainCompany() {
            self.connectionState = .CorrectWifi
            self.company = company
            self.trainCommunicator = TrainCommunicator(for: company)
        } else {
            self.connectionState = .WrongWifi
        }
#endif
    }
}

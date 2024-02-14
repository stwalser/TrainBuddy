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
    @ObservationIgnored let refreshInterval = 1.0
    @ObservationIgnored let trainWifiManager = TrainWiFiManager()
    @ObservationIgnored var company: Company?
    @ObservationIgnored var trainCommunicator: TrainCommunicator?
    @ObservationIgnored var timer = Timer()

    var connectionState: ConnectionState = .Starting
    var trainState: TrainState?
    
    func triggerTimer() {
        self.timer =  Timer.scheduledTimer(withTimeInterval: self.refreshInterval, repeats: true) { _ in
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
                        self.connectionState = .Error
                    }
                }
            case .Fetching:
                Task {
                    do {
                        await self.trainState!.update(try await self.trainCommunicator!.fetchCombinedState())
                    } catch {
                        self.connectionState = .Error
                    }
                }
            case .Error:
                Task {
                    await self.checkWifiState()
                }
            }
        }
    }
    
    func addLiveActivity() {
        Task {
            await self.trainState!.startLiveActivity()
        }
    }
    
    func removeLiveActivity() {
        Task {
            await self.trainState!.stopLiveActivity()
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

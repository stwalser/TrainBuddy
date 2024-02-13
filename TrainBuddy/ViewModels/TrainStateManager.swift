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
}

@Observable class TrainStateManager {
    let refreshInterval = 1.0
    let url = "https://railnet.oebb.at/assets/modules/fis/combined.json"
    let trainWifiManager = TrainWiFiManager(ssid: "OEBB")
    var timer = Timer()
    
    var combinedState: CombinedState?
    var connectionState: ConnectionState = .Starting
    var upcomingStations: [Station]?
    var relevantStations: [Station]?
    var userDestination: Station?
    
    func triggerTimer() {
        self.timer =  Timer.scheduledTimer(withTimeInterval: self.refreshInterval, repeats: true) { _ in
            switch self.connectionState {
            case .Starting:
                Task {
                    await self.checkWifi()
                }
            case .WrongWifi:
                Task {
                    await self.trainWifiManager.connectToWiFi()
                    await self.checkWifi()
                }
            case .CorrectWifi:
                self.fetchCombinedState()
            case .Fetching:
                self.fetchCombinedState()
            }
        }
    }
        
    private func checkWifi() async {
#if targetEnvironment(simulator)
        self.connectionState = .CorrectWifi
#else
        if await self.trainWifiManager.deviceConnectedToTrainWiFi() {
            self.connectionState = .CorrectWifi
        } else {
            self.connectionState = .WrongWifi
        }
#endif
    }
    
    private func fetchCombinedState() {
        Task {
            do {
                let combined = try await self.doRequest()
                await MainActor.run {
                    self.combinedState = combined
                }
                
                let upcomingStations = self.getUpcomingStations()
                await MainActor.run {
                    if self.relevantStations == nil { // do only first time to not override user choice
                        self.userDestination = upcomingStations.last!
                    }
                    self.upcomingStations = upcomingStations
                    
                }
                
                let relevantStations = self.getRelevantStations()
                await MainActor.run {
                    self.relevantStations = relevantStations
                    self.connectionState = .Fetching
                }
            } catch {
                print(error)
                await MainActor.run {
                    self.connectionState = .WrongWifi
                }
            }
        }
    }
    
    private func doRequest() async throws -> CombinedState {
#if targetEnvironment(simulator)
        if let url = Bundle.main.url(forResource: "combined-2", withExtension: ".json") {
            let json = try Data(contentsOf: url)
            return try JSONDecoder().decode(CombinedState.self, from: json)
        }
        throw CombinedStateError.decodeError("File")
#else
        let url = URL(string: self.url)!
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        urlSession.configuration.waitsForConnectivity = true

        let (json, _) = try await urlSession.data(for: urlRequest)
        
        return try JSONDecoder().decode(CombinedState.self, from: json)
#endif
    }
    
    private func getUpcomingStations() -> [Station] {
        var stations = [Station]()
        var nextStationFound = false

        if let state = self.combinedState {
            for station in state.stations {
                if !nextStationFound && station == state.nextStation {
                    nextStationFound = true
                }
                
                if nextStationFound {
                    stations.append(station)
                }
            }
        }
        return stations
    }
    
    private func getRelevantStations() -> [Station] {
        var stations = [Station]()
        
        if let userDestination = userDestination {
            for station in self.upcomingStations! {
                stations.append(station)
                
                if station == userDestination {
                    break
                }
            }
        }
        
        return stations
    }
}

//
//  ConnectionManager.swift
//  RailnetApp
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation
import NetworkExtension

enum AppState {
    case Starting
    case PollingWiFi
    case FetchingInfo
}

class TrainStateManager: ObservableObject {
    let url = "https://railnet.oebb.at/assets/modules/fis/combined.json"
    let railnetSSID = "OEBB"
    
    var timer = Timer()
    @Published var combinedState: CombinedState?
    @Published var appState: AppState = .Starting
    
    func startSSIDPolling() {
        self.timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let ssid = self.fetchWiFiSSID()
            print(ssid)
            // if ssid == self.railnetSSID {
                timer.invalidate()
                self.startFetchingState()
            // }
        }
    }
    
    private func startFetchingState() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            Task {
                do {
                    let combined = try await self.fetchState()
                    await MainActor.run {
                        self.combinedState = combined
                        self.appState = .FetchingInfo
                    }
                } catch {
                    print(error)
                    self.goToPollingState()
                }
            }
        }
    }
    
    private func goToPollingState() {
        self.appState = .PollingWiFi
        self.startSSIDPolling()
    }
    
    private func fetchState() async throws -> CombinedState {
        let url = URL(string: self.url)!
        let urlRequest = URLRequest(url: url)

        let (json, _) = try await URLSession.shared.data(for: urlRequest)
        
        return try JSONDecoder().decode(CombinedState.self, from: json)
    }
    
    private func fetchWiFiSSID() -> String {
        var ssid = ""
        NEHotspotNetwork.fetchCurrent { hotspotNetwork in
            if let hotspotNetwork = hotspotNetwork {
                ssid = hotspotNetwork.ssid
            }
        }
        return ssid
    }
}


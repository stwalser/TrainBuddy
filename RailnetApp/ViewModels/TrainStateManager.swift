//
//  ConnectionManager.swift
//  RailnetApp
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation
import NetworkExtension

enum ConnectionState {
    case Starting
    case WrongWifi
    case CorrectWifi
    case Fetching
}

class TrainStateManager: ObservableObject {
    let url = "https://railnet.oebb.at/assets/modules/fis/combined.json"
    let railnetSSID = "OEBB"
    
    var timer = Timer()
    @Published var combinedState: CombinedState?
    @Published var connectionState: ConnectionState = .Starting
    
    func getTitle() -> String {
        if let combinedState {
            return "\(combinedState.trainType) \(combinedState.lineNumber)"
        }
        return "TrainBuddy"
    }
    
    func triggerTimer() {
        self.timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            switch self.connectionState {
            case .Starting:
                self.checkWifi()
            case .WrongWifi:
                self.checkWifi()
            case .CorrectWifi:
                self.fetchCombinedState()
            case .Fetching:
                self.fetchCombinedState()
            }
        }
    }
    
    private func checkWifi() {
        let ssid = self.fetchWiFiSSID()
        print(ssid)
//        if ssid == self.railnetSSID {
            self.connectionState = .CorrectWifi
//        } else {
//            self.connectionState = .WrongWifi
//        }
    }
    
    private func fetchCombinedState() {
        Task {
            do {
                let combined = try await self.doRequest()
                await MainActor.run {
                    self.combinedState = combined
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
//        let url = URL(string: self.url)!
//        let urlRequest = URLRequest(url: url)
//
//        let (json, _) = try await URLSession.shared.data(for: urlRequest)
        
        if let url = Bundle.main.url(forResource: "combined", withExtension: ".json") {
            let json = try Data(contentsOf: url)
            
            return try JSONDecoder().decode(CombinedState.self, from: json)
        }
        throw CombinedStateError.decodeError("File")
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


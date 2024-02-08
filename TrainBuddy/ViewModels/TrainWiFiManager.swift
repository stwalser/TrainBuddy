//
//  TrainWiFIManager.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 08.02.24.
//

import Foundation
import NetworkExtension
import CoreLocation

class TrainWiFiManager: NSObject, CLLocationManagerDelegate {
    let ssid: String
    let wifiConfiguration: NEHotspotConfiguration
    let locationManager: CLLocationManager
    
    var trainWiFiVisible = true
    
    init(ssid: String) {
        self.ssid = ssid
        self.wifiConfiguration = NEHotspotConfiguration(ssid: ssid)
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
    }
    
    func connectToWiFi() async {
        do {
            if UserDefaults.standard.bool(forKey: "autoWiFiConnectOn") && self.trainWiFiVisible {
                try await NEHotspotConfigurationManager.shared.apply(self.wifiConfiguration)
            }
        } catch  {
            self.trainWiFiVisible = false
        }
    }
    
    func deviceConnectedToTrainWiFi() async -> Bool {
        if let ssid = await NEHotspotNetwork.fetchCurrent()?.ssid {
            return ssid == self.ssid
        }
        return false
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { }
}


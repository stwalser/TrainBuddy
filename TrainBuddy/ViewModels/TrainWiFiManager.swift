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
    let locationManager = CLLocationManager()
    
    var trainWiFiVisible = true
    
    override init() {
        super.init()
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
    }
    
    func connectToWiFi() async {
        //                As it would be necessary to connect to many different WiFis, in the future, this feature is currently not used.
//        do {
//            if UserDefaults.standard.bool(forKey: "autoWiFiConnectOn") && self.trainWiFiVisible {
//                try await NEHotspotConfigurationManager.shared.apply()
//            }
//        } catch  {
//            self.trainWiFiVisible = false
//        }
    }
    
    func getTrainCompany() async -> Company? {
        if let ssid = await NEHotspotNetwork.fetchCurrent()?.ssid {
            for company in Company.allCases {
                if company.rawValue == ssid {
                    return company
                }
            }
        }
        return nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { }
}


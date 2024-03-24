//
//  TrainCompanyInfos.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 13.02.24.
//

import Foundation
import NetworkExtension

let companyDict = [
    "OEBB": [
        "ssid": "OEBB",
        "wifiConfiguration": NEHotspotConfiguration(ssid: "OEBB"),
        "contentURL": "https://railnet.oebb.at/assets/modules/fis/combined.json"
    ]
]

enum Company: String, CaseIterable {
case OEBB
}

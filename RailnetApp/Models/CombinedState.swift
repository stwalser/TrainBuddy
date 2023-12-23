//
//  CombinedState.swift
//  RailnetApp
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation

enum CombinedStateError: Error {
    case decodeError(String)
}

struct TrainInfo: Decodable {
    let speed: Int
    let gpsPosition: GPSPosition
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case gpsPosition
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawSpeed = try? container.decode(Int.self, forKey: .speed)
        let rawGpsPosition = try? container.decode(GPSPosition.self, forKey: .gpsPosition)
        
        guard let speed = rawSpeed,
              let gpsPosition = rawGpsPosition
        else {
            throw CombinedStateError.decodeError("Some value decoded to nil in local State struct")
        }
        
        self.speed = speed
        self.gpsPosition = gpsPosition
    }
}

struct Station: Decodable {
    let all: String
    let de: String
}

struct GPSPosition: Decodable {
    let latitude: String
    let longitude: String
    let orientation: String?
}

struct CombinedState: Decodable {
    let lineNumber: String
    let tripNumber: String
    let trainType: String
    let startStation: String
    let destination: Station
    let latestStatus: TrainInfo
    
    private enum CodingKeys: String, CodingKey {
        case lineNumber
        case tripNumber
        case trainType
        case startStation
        case destination
        case latestStatus
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawLineNumber = try? container.decode(String.self, forKey: .lineNumber)
        let rawTripNumber = try? container.decode(String.self, forKey: .tripNumber)
        let rawTrainType = try? container.decode(String.self, forKey: .trainType)
        let rawStartStation = try? container.decode(String.self, forKey: .startStation)
        let rawDestination = try? container.decode(Station.self, forKey: .destination)
        let rawLatestStatus = try? container.decode(TrainInfo.self, forKey: .latestStatus)
        
        guard let lineNumber = rawLineNumber,
              let tripNumber = rawTripNumber,
              let trainType = rawTrainType,
              let startStation = rawStartStation,
              let destination = rawDestination,
              let latestStatus = rawLatestStatus
        else {
            throw CombinedStateError.decodeError("Some value decoded to nil in global struct.")
        }
        
        self.lineNumber = lineNumber
        self.tripNumber = tripNumber
        self.trainType = trainType
        self.startStation = startStation
        self.destination = destination
        self.latestStatus = latestStatus
    }
}

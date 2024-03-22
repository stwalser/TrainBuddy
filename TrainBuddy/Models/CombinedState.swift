//
//  CombinedState.swift
//  RailnetApp
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation

// MARK: Error

enum CombinedStateError: Error {
    case decodeError(String)
}

// MARK: Info

struct TrainInfo: Decodable {
    let speed: Int
    let gpsPosition: GPSPosition?
    let totalDealy: Int
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case gpsPosition
        case totalDelay
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawSpeed = try? container.decode(Int.self, forKey: .speed)
        let rawGpsPosition = try? container.decode(GPSPosition.self, forKey: .gpsPosition)
        let rawTotalDelay = try? container.decode(Int.self, forKey: .totalDelay)

        guard let speed = rawSpeed,
        let totalDelay = rawTotalDelay
        else {
            throw CombinedStateError.decodeError("Some value decoded to nil in train info struct")
        }
        
        self.speed = speed
        self.gpsPosition = rawGpsPosition
        self.totalDealy = totalDelay
    }
}

struct Connection: Decodable, Identifiable {
    var id: String {
        type + " " + lineNumber + " " + destination.de!
    }
    
    let type: String
    let lineNumber: String
    let track: MultiLang?
    let destination: MultiLang
    let departure: Time
    let reachable: String
    let comment: String?
}

struct Station: Decodable, Identifiable, Hashable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: MultiLang
    let track: MultiLang?
    let departure: Time
    let arrival: Time
    let exitSide: String?
    let distanceFromPrevious: Int?
    let connections: [Connection]?
}

struct MultiLang: Decodable {
    let all: String?
    let de: String?
}

struct Time: Decodable {
    let scheduled: String
    let forecast: String?
}

struct GPSPosition: Decodable {
    let latitude: String
    let longitude: String
    let orientation: String?
}

struct CombinedState: Decodable, Identifiable {
    var id: String {
        trainType + " " + lineNumber
    }
    
    let lineNumber: String
    let tripNumber: String
    let trainType: String
    let won: String
    let startStation: String
    let destination: MultiLang
    let stations: [Station]
    let latestStatus: TrainInfo
    let currentStation: Station
    let nextStation: Station
    let nextStationProgress: Int
}

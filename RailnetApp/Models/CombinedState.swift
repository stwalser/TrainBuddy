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
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case gpsPosition
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawSpeed = try? container.decode(Int.self, forKey: .speed)
        let rawGpsPosition = try? container.decode(GPSPosition.self, forKey: .gpsPosition)

        guard let speed = rawSpeed else {
            throw CombinedStateError.decodeError("Some value decoded to nil in local State struct")
        }
        
        self.speed = speed
        self.gpsPosition = rawGpsPosition
    }
}

struct Connection: Decodable {
    let type: String
    let lineNumber: String
    let track: MultiLang
    let destination: MultiLang
    let departure: Time
    let reachable: String
    let comment: String?
}

struct Station: Decodable, Identifiable {
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

struct CombinedState: Decodable {
    let lineNumber: String
    let tripNumber: String
    let trainType: String
    let startStation: String
    let destination: MultiLang
    let latestStatus: TrainInfo
    let nextStation: Station
    let nextStationProgress: Int
    let stations: [Station]
    
    private enum CodingKeys: String, CodingKey {
        case lineNumber
        case tripNumber
        case trainType
        case startStation
        case destination
        case latestStatus
        case nextStation
        case nextStationProgress
        case stations
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawLineNumber = try? container.decode(String.self, forKey: .lineNumber)
        let rawTripNumber = try? container.decode(String.self, forKey: .tripNumber)
        let rawTrainType = try? container.decode(String.self, forKey: .trainType)
        let rawStartStation = try? container.decode(String.self, forKey: .startStation)
        let rawDestination = try? container.decode(MultiLang.self, forKey: .destination)
        let rawLatestStatus = try? container.decode(TrainInfo.self, forKey: .latestStatus)
        let rawNextStation = try? container.decode(Station.self, forKey: .nextStation)
        let rawNextStaitonProgress = try? container.decode(Int.self, forKey: .nextStationProgress)
        let rawStations = try? container.decode([Station].self, forKey: .stations)
        
        guard let lineNumber = rawLineNumber,
              let tripNumber = rawTripNumber,
              let trainType = rawTrainType,
              let startStation = rawStartStation,
              let destination = rawDestination,
              let latestStatus = rawLatestStatus,
              let nextStation = rawNextStation,
              let nextStationProgress = rawNextStaitonProgress,
              let stations = rawStations
        else {
            throw CombinedStateError.decodeError("Some value decoded to nil in global struct.")
        }
        
        self.lineNumber = lineNumber
        self.tripNumber = tripNumber
        self.trainType = trainType
        self.startStation = startStation
        self.destination = destination
        self.latestStatus = latestStatus
        self.nextStation = nextStation
        self.nextStationProgress = nextStationProgress
        self.stations = stations
    }
}

extension String {
    func utf8DecodedString() -> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
}

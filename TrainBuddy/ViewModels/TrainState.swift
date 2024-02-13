//
//  TrainState.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 13.02.24.
//

import Foundation

@Observable class TrainState {
    let company: Company
    let liveActivityManager = LiveActivityManager()
    let dateFormatter = DateFormatter()
    
    var state: CombinedState {
        didSet {
            Task {
                await self.liveActivityManager.updateLiveActivity(timeLeft: self.timeUntilDestination.description, userDestination: userDestination.name.de!, nextStation: state.nextStation.name.de!, speed: String(state.latestStatus.speed))
            }
        }
    }
    
    var upcomingStations: [Station] {
        var stations = [Station]()
        var nextStationFound = false

        for station in state.stations {
            if !nextStationFound && station == state.nextStation {
                nextStationFound = true
            }
            
            if nextStationFound {
                stations.append(station)
            }
        }
        return stations
    }
    
    var relevantStations: [Station] {
        var stations = [Station]()
        
        let userDestination = self.userDestination
        
        for station in self.upcomingStations {
            stations.append(station)
            
            if station == userDestination {
                break
            }
        }
        
        return stations
    }
    var userDestination: Station
    
    var timeUntilDestination: DateInterval {
        let arrivalTime = self.dateFormatter.date(from: self.userDestination.arrival.forecast ?? self.userDestination.arrival.scheduled)!
        let now = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        var dateComponents = gregorian.dateComponents(components, from: now)
        let calendar = Calendar.current
        dateComponents.hour = calendar.component(.hour, from: arrivalTime)
        dateComponents.minute = calendar.component(.minute, from: arrivalTime)
        
#if targetEnvironment(simulator)
        let mockComponents = DateComponents(hour: 7, minute: 45)
        return DateInterval(start: gregorian.date(from: mockComponents)!, end: gregorian.date(from: dateComponents)!)
#else
        return DateInterval(start: now, end: gregorian.date(from: dateComponents)!)
#endif
    }
    
    init(for company: Company, state: CombinedState) {
        self.company = company
        self.state = state
        self.dateFormatter.dateFormat = "HH:mm"
        self.userDestination = state.stations.last!
    }
    
    func update(_ state: CombinedState) {
        self.state = state
    }
    
    @MainActor
    func startLiveActivity() {
        self.liveActivityManager.startLiveActivity(trainID: state.id, timeLeft: self.timeUntilDestination.description, userDestination: self.userDestination.name.de!, nextStation: state.nextStation.name.de!, speed: String(state.latestStatus.speed))
    }
    
    @MainActor
    func stopLiveActivity() {
        Task {
            await self.liveActivityManager.stopActivity(timeLeft: "", userDestination: userDestination.name.de!, nextStation: state.nextStation.name.de!, speed: String(state.latestStatus.speed))
        }
    }
    
    deinit {
        Task {
            await stopLiveActivity()
        }
    }
}

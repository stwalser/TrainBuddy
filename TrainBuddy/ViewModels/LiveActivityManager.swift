//
//  LiveActivityManager.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 13.02.24.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    var currentActivity: Activity<TrainBuddyWidgetAttributes>?
    
    func startLiveActivity(trainID: String, timeLeft: String, userDestination: String, nextStation: String, speed: String)  {
        if ActivityAuthorizationInfo().areActivitiesEnabled && UserDefaults.standard.bool(forKey: "liveActivitiyOn") {
            do {
                let attributes = TrainBuddyWidgetAttributes(trainID: trainID)
                let initialState = TrainBuddyWidgetAttributes.ContentState(timeLeft: timeLeft, userDestination: userDestination, nextStation: nextStation, speed: speed)
                
                self.currentActivity = try Activity.request(attributes: attributes, content: .init(state: initialState, staleDate: nil))
            } catch {
                print("Setting up the Live Activity failed. \(error)")
            }
        }
    }
    
    func updateLiveActivity(timeLeft: String, userDestination: String, nextStation: String, speed: String) async {
        guard let activity = self.currentActivity else {
            return
        }
        
        let contentState = TrainBuddyWidgetAttributes.ContentState(timeLeft: timeLeft, userDestination: userDestination, nextStation: nextStation, speed: speed)
        
        await activity.update(ActivityContent<Activity<TrainBuddyWidgetAttributes>.ContentState>(state: contentState, staleDate: Date.now + 5))
    }
    
    func stopActivity(timeLeft: String, userDestination: String, nextStation: String, speed: String) async {
        guard let activity = currentActivity else {
            return
        }
        
        let finalContent = TrainBuddyWidgetAttributes.ContentState(timeLeft: timeLeft, userDestination: userDestination, nextStation: nextStation, speed: speed)
        
        await activity.end(ActivityContent<Activity<TrainBuddyWidgetAttributes>.ContentState>(state: finalContent, staleDate: nil))
    }
}

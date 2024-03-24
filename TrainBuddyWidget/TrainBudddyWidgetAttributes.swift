//
//  TrainBudddyWidgetAttributes.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 13.02.24.
//

import Foundation
import ActivityKit

struct TrainBuddyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var timeLeft: String
        var userDestination: String
        var nextStation: String
        var speed: String
    }

    // Fixed non-changing properties about your activity go here!
    var trainID: String
}

//
//  TrainBuddyWidgetLiveActivity.swift
//  TrainBuddyWidget
//
//  Created by Stefan Walser on 03.02.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TrainBuddyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TrainBuddyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrainBuddyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TrainBuddyWidgetAttributes {
    fileprivate static var preview: TrainBuddyWidgetAttributes {
        TrainBuddyWidgetAttributes(name: "World")
    }
}

extension TrainBuddyWidgetAttributes.ContentState {
    fileprivate static var smiley: TrainBuddyWidgetAttributes.ContentState {
        TrainBuddyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TrainBuddyWidgetAttributes.ContentState {
         TrainBuddyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TrainBuddyWidgetAttributes.preview) {
   TrainBuddyWidgetLiveActivity()
} contentStates: {
    TrainBuddyWidgetAttributes.ContentState.smiley
    TrainBuddyWidgetAttributes.ContentState.starEyes
}

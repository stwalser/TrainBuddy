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
        var timeLeft: String
        var userDestination: String
    }

    // Fixed non-changing properties about your activity go here!
    var trainID: String
}

struct TrainBuddyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrainBuddyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                VStack(alignment: .leading) {
                    ZStack {
                        Text(context.attributes.trainID)
                            .font(.system(.title3, weight: .bold))
                            .fontDesign(.rounded)
                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                    Spacer()
                    
                    HStack {
                        Text(context.state.timeLeft)
                            .foregroundStyle(Color.accentColor)
                        Text("bis")
                        Text(context.state.userDestination)
                            .foregroundStyle(Color.accentColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                    
                    Image(systemName: "train.side.front.car")
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    
                }
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.trainID)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Noch \(context.state.timeLeft)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Ziel: \(context.state.userDestination)")
                    // more content
                }
            } compactLeading: {
                Image(systemName: "train.side.front.car")
            } compactTrailing: {
                Text(context.state.timeLeft)
            } minimal: {
                Text(context.attributes.trainID)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TrainBuddyWidgetAttributes {
    fileprivate static var preview: TrainBuddyWidgetAttributes {
        TrainBuddyWidgetAttributes(trainID: "RJX 162")
    }
}

extension TrainBuddyWidgetAttributes.ContentState {
    fileprivate static var vienna: TrainBuddyWidgetAttributes.ContentState {
        TrainBuddyWidgetAttributes.ContentState(timeLeft: "59 min", userDestination: "Wien Hbf")
     }
}

#Preview("Notification", as: .content, using: TrainBuddyWidgetAttributes.preview) {
   TrainBuddyWidgetLiveActivity()
} contentStates: {
    TrainBuddyWidgetAttributes.ContentState.vienna
}

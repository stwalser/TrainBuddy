//
//  TrainBuddyWidgetLiveActivity.swift
//  TrainBuddyWidget
//
//  Created by Stefan Walser on 03.02.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TrainBuddyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrainBuddyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(alignment: .leading) {
                Text(context.attributes.trainID)
                    .font(.system(.title3, weight: .heavy))
                    .foregroundStyle(titleColor)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
                
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        HStack {
                            Text(context.state.speed)
                            Text("km/h")
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 5))
                        
                        HStack {
                            Text(context.state.timeLeft)
                                .foregroundStyle(Color.accentColor)
                            Text("bis")
                            Text(context.state.userDestination)
                                .foregroundStyle(Color.accentColor)
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 5))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Nächster Halt")
                            .font(.system(.subheadline, weight: .bold))
                            .foregroundStyle(titleColor)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                        
                        Text(context.state.nextStation)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 10))
                        
                        Spacer()
                    }
                }
                
                Image(systemName: "train.side.front.car")
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 5))
            }
            .fontDesign(.rounded)
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
                Image(systemName: "train.side.front.car")
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
        TrainBuddyWidgetAttributes.ContentState(timeLeft: "59 min", userDestination: "Wien Hbf", nextStation: "Salzburg Hbf", speed: "0")
     }
}

#Preview("Notification", as: .content, using: TrainBuddyWidgetAttributes.preview) {
   TrainBuddyWidgetLiveActivity()
} contentStates: {
    TrainBuddyWidgetAttributes.ContentState.vienna
}

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
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(context.attributes.trainID)
                            .font(.system(.title))
                            .bold()
                            .foregroundStyle(.white)
                           
                        Spacer()
                        
                        HStack {
                            Text(context.state.speed)
                            Text("km/h")
                        }
                        .font(.system(.title2))
                        .foregroundStyle(.white)
                        .bold()
                    }
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                    
                    HStack {
                        VStack(alignment: .leading) {
                           Spacer()
                            
                            HStack {
                                Text(context.state.timeLeft)
                                    .foregroundStyle(complementaryTitleColor)
                                    .bold()
                                Text("bis")
                                    .foregroundStyle(.white)
                                    .bold()
                                Text(context.state.userDestination)
                                    .foregroundStyle(complementaryTitleColor)
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            
                            Text("Nächster Halt")
                                .font(.system(.subheadline))
                                .bold()
                                .foregroundStyle(.white)
                                
                            Text(context.state.nextStation)
                                .font(.system(.title3))
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
                    
//                    Image(systemName: "train.side.front.car")
//                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                }
                .opacity(context.isStale ? 0.2 : 1.0)
                
                if context.isStale {
                    Text("Verbindung verloren...")
                }
            }
            .background(titleColor)
            .fontDesign(.rounded)
            .activityBackgroundTint(Color(UIColor.tertiarySystemBackground))
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
                    .foregroundStyle(titleColor)
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

//
//  InfoView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI

struct InfoView: View {
    @State var trainStateManager: TrainStateManager
        
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(trainStateManager.combinedState!.startStation)
                    Text("→")
                    Text(trainStateManager.combinedState!.destination.de!)
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                let delay: Int = {
                    trainStateManager.combinedState!.latestStatus.totalDealy / 60
                }()
                
                if delay > 0  {
                    Text("+\(delay)")
                        .foregroundStyle(.orange)
                } else {
                    Text("+0")
                        .foregroundStyle(.green)
                }
                
                Text("\(trainStateManager.combinedState!.latestStatus.speed) km/h")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .font(.system(.callout, design: .rounded))
            }
           
            
            ScrollView {
                UserDestinationView(trainStateManager: trainStateManager)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(backgroundColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                NextStationView(trainStateManager: trainStateManager)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(backgroundColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                NextStationsView(trainStateManager: trainStateManager)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(backgroundColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                TrainMapView(trainStateManager: trainStateManager)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(backgroundColor)
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .navigationTitle(trainStateManager.combinedState!.trainType + " " + trainStateManager.combinedState!.lineNumber)
    }
}

#Preview {
    struct Preview: View {
        @State var trainStateManager = TrainStateManager()
        @StateObject var dataController = DataController()
        
        init() {
            trainStateManager.triggerTimer()
        }
        
        var body: some View {
            if trainStateManager.connectionState == .Fetching {
                InfoView(trainStateManager: trainStateManager)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
    
    return Preview()
}

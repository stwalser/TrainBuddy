//
//  InfoView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI

struct InfoView: View {
    @State var trainState: TrainState
        
    var body: some View {
        VStack {
           SectionTitle("Allgemein")
            
            HStack {
                SingleInfo(main: "\(trainState.state.startStation) → \(trainState.state.destination.de!)", caption: "")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            let delay: Int = {
                trainState.state.latestStatus.totalDealy / 60
            }()
            
            HStack {
                SingleInfo(main: String(trainState.state.latestStatus.speed), caption: "km/h")
                
                if delay > 0  {
                    Divider()
                        .frame(height: 40)
                    
                    SingleInfo(main: "+\(delay)", caption: "min")
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            Divider()
            
            ScrollView {
                UserDestinationView(trainState: trainState)
                
                NextStationView(trainState: trainState)
                    
                NextStationsView(trainState: trainState)
                
                TrainMapView(trainState: trainState)
            }
        }
        .navigationTitle(trainState.state.id)
    }
}

#Preview {
    struct Preview: View {
        @State var appContentManager = AppContentManager()
        @StateObject var dataController = DataController()
        
        init() {
            appContentManager.triggerTimer()
        }
        
        var body: some View {
            if appContentManager.connectionState == .Fetching {
                NavigationView {
                    InfoView(trainState: appContentManager.trainState!)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .fontDesign(.rounded)
                }
            }
        }
    }
    
    return Preview()
}

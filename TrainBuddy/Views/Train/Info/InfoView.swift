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
           SectionTitle("Allgemein")
            
            HStack {
                SingleInfo(main: "\(trainStateManager.trainState!.state.startStation) → \(trainStateManager.trainState!.state.destination.de!)", caption: "")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            let delay: Int = {
                trainStateManager.trainState!.state.latestStatus.totalDealy / 60
            }()
            
            HStack {
                SingleInfo(main: String(trainStateManager.trainState!.state.latestStatus.speed), caption: "km/h")
                
                if delay > 0  {
                    Divider()
                        .frame(height: 40)
                    
                    SingleInfo(main: "+\(delay)", caption: "min")
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            Divider()
            
            ScrollView {
                UserDestinationView(trainStateManager: trainStateManager)
                
                NextStationView(trainStateManager: trainStateManager)
                    
                NextStationsView(trainStateManager: trainStateManager)
                
                TrainMapView(trainStateManager: trainStateManager)
            }
        }
        .navigationTitle(trainStateManager.trainState!.state.id)
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
                NavigationView {
                    InfoView(trainStateManager: trainStateManager)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .fontDesign(.rounded)
                }
            }
        }
    }
    
    return Preview()
}

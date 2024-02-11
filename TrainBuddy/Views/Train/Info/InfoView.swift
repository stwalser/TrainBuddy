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
                SingleInfo(main: "\(trainStateManager.combinedState!.startStation) → \(trainStateManager.combinedState!.destination.de!)", caption: "")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            let delay: Int = {
                trainStateManager.combinedState!.latestStatus.totalDealy / 60
            }()
            
            HStack {
                SingleInfo(main: String(trainStateManager.combinedState!.latestStatus.speed), caption: "km/h")
                
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
                    .fontDesign(.rounded)
            }
        }
    }
    
    return Preview()
}

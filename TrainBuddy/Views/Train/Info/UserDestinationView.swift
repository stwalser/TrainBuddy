//
//  UserDestinationView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 02.02.24.
//

import SwiftUI

struct UserDestinationView: View {
    @State var trainStateManager: TrainStateManager
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var usedTrains: FetchedResults<UsedTrain>
    
    var body: some View {
        VStack {
            SectionTitle("Mein Ziel")
                        
            HStack {
                HStack {
                    Picker("", selection: Binding($trainStateManager.trainState)!.userDestination) {
                        ForEach(trainStateManager.trainState!.upcomingStations, id: \.self) { station in
                            Text(station.name.de!).tag(station as Station?)
                        }
                    }
                    .onAppear(perform: {
                        parseUserDestinations()
                    })
                    .onChange(of: trainStateManager.trainState!.userDestination) {
                        storeUserDestination()
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
    
    private func storeUserDestination() {
        let usedTrain = UsedTrain(context: moc)
        usedTrain.id = trainStateManager.trainState!.state.id
        usedTrain.destination = trainStateManager.trainState!.userDestination.name.de!

        try? moc.save()
    }
    
    private func parseUserDestinations() {
        for train in usedTrains {
            if train.id == trainStateManager.trainState!.state.id {
                trainStateManager.trainState!.userDestination = trainStateManager.trainState!.state.stations.first(where: { station in
                    station.name.de! == train.destination
                })!
            }
        }
    }
}

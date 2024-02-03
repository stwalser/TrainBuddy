//
//  UserDestinationView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 02.02.24.
//

import SwiftUI

struct UserDestinationView: View {
    @EnvironmentObject var trainStateManager: TrainStateManager
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var usedTrains: FetchedResults<UsedTrain>
    
    var body: some View {
        VStack {
            HStack {
                Label("Mein Ziel", systemImage: "person")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            Divider()
            
            Picker("", selection: $trainStateManager.userDestination) {
                ForEach(trainStateManager.upcomingStations!, id: \.self) { station in
                    Text(station.name.de!).tag(station as Station?)
                }
            }
            .onAppear(perform: {
                parseUserDestinations()
            })
            .onChange(of: trainStateManager.userDestination) {
                storeUserDestination()
            }
        }
        .background(RoundedRectangle(cornerRadius: 5.0).fill(.white))
        .foregroundStyle(.black)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    private func storeUserDestination() {
        let usedTrain = UsedTrain(context: moc)
        usedTrain.id = trainStateManager.combinedState!.id
        usedTrain.destination = trainStateManager.userDestination!.name.de!

        try? moc.save()
    }
    
    private func parseUserDestinations() {
        for train in usedTrains {
            if train.id == trainStateManager.combinedState!.id {

                trainStateManager.userDestination = trainStateManager.combinedState!.stations.first(where: { station in
                    station.name.de! == train.destination
                })
            }
        }
    }
}

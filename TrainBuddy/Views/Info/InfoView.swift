//
//  InfoView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI

struct InfoView: View {
    @State var trainStateManager: TrainStateManager
        
    var body: some View {
        HStack {
            Text(trainStateManager.combinedState!.startStation.utf8DecodedString())
            Text("→")
            Text(trainStateManager.combinedState!.destination.de!)
        }
        
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
        
        ScrollView {
            UserDestinationView(trainStateManager: trainStateManager)
            
            NextStationView(trainStateManager: trainStateManager)
            
            NextStationsView(trainStateManager: trainStateManager)
            
            TrainMapView(trainStateManager: trainStateManager)
        }
        
    }
}

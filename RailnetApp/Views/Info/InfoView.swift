//
//  InfoView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI

let tileColor = Color(red: 245/256, green: 245/256, blue: 245/256)

struct InfoView: View {
    @EnvironmentObject var trainStateManager: TrainStateManager
    @State var smallSquareSideLength: CGFloat = .zero
    @State var bigSquareSideLength: CGFloat = .zero
    
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
            NextStationView().environmentObject(trainStateManager)
            
            NextStationsView().environmentObject(trainStateManager)
            
            TrainMapView().environmentObject(trainStateManager)
        }
    }
}

#Preview {
    InfoView()
}

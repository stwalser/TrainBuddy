//
//  InfoView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI
import MapKit

struct InfoView: View {
    @EnvironmentObject var trainStateManager: TrainStateManager
    
    var body: some View {
        ScrollView {
            Text(trainStateManager.getTitle())
                .font(.largeTitle)
                .padding(EdgeInsets(top: 20.0, leading: 5.0, bottom: 0.0, trailing: 5.0))
            
            HStack {
                Text(trainStateManager.combinedState!.startStation)
                Text("→")
                Text(trainStateManager.combinedState!.destination.de)
            }
            
            Text("\(trainStateManager.combinedState!.latestStatus.speed) km/h")
                .padding()
            
            Map {
                Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition.latitude)!, longitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition.latitude)!))
                {
                    Text("🚄")
                        .padding()
                }
            }
            .mapControls {
                MapScaleView()
            }
            
            Text(trainStateManager.combinedState!.latestStatus.gpsPosition.latitude)
            Text(trainStateManager.combinedState!.latestStatus.gpsPosition.longitude)
        }
        
    }
}

#Preview {
    InfoView()
}

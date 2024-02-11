//
//  TrainMapView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI
import MapKit

struct TrainMapView: View {
    @State var trainStateManager: TrainStateManager
    
    var body: some View {
        VStack {
            SectionTitle("Karte")
                        
            if trainStateManager.combinedState!.latestStatus.gpsPosition != nil {
                Map(bounds: MapCameraBounds(minimumDistance: 2000, maximumDistance: nil)) {
                    Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.latitude)!, longitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.longitude)!))
                    {
                        Image(systemName: "train.side.front.car")
                            .padding()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
            } else {
                Text("Der Zug stellt momentan keine GPS Daten zur Verfügung. 😢")
            }
            
            Spacer()
            
        }
        .frame(minHeight: 400)
    }
}

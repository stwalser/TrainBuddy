//
//  TrainMapView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI
import MapKit

struct TrainMapView: View {
    var trainState: TrainState
    
    var body: some View {
        VStack {
            SectionTitle("Karte")
                        
            if let gpsPosition = trainState.state.latestStatus.gpsPosition {
                Map(bounds: MapCameraBounds(minimumDistance: 10000, maximumDistance: nil)) {
                    Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(gpsPosition.latitude)!, longitude: Double(gpsPosition.longitude)!))
                    {
                        Image(systemName: "train.side.front.car")
                            .foregroundStyle(titleColor)
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

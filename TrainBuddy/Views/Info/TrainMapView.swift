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
            HStack {
                Label("Karte", systemImage: "map")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            Divider()
            
            if trainStateManager.combinedState!.latestStatus.gpsPosition != nil {
                Map(bounds: MapCameraBounds(minimumDistance: 2000, maximumDistance: nil)) {
                    Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.latitude)!, longitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.longitude)!))
                    {
                        Text("🚄")
                            .padding()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                
            } else {
                Text("Der Zug stellt momentan keine GPS Daten zur Verfügung. 😢")
            }
            
            Spacer()
            
        }
        .frame(minHeight: 400)
        .background(RoundedRectangle(cornerRadius: 5.0).fill(.white))
        .foregroundStyle(.black)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

//
//  InfoView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 23.12.23.
//

import SwiftUI
import MapKit

struct InfoView: View {
    let tileColor = Color(red: 245/256, green: 245/256, blue: 245/256)
    
    @EnvironmentObject var trainStateManager: TrainStateManager
    @State var smallSquareSideLength: CGFloat = .zero
    @State var bigSquareSideLength: CGFloat = .zero
    
    var body: some View {
        HStack {
            Text(trainStateManager.combinedState!.startStation.utf8DecodedString())
            Text("→")
            Text(trainStateManager.combinedState!.destination.de!)
        }
        
        Text("\(trainStateManager.combinedState!.latestStatus.speed) km/h")
            .padding()
        
        ScrollView {
            VStack {
                HStack {
                    Label("Nächste Halte", systemImage: "calendar")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                
                Divider()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(trainStateManager.relevantStations!) {station in
                            VStack {
                                Text(station.name.de!)
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                
                                TimeEventView(timeEvent: station.arrival, eventType: "Ankunft")
                                TimeEventView(timeEvent: station.departure, eventType: "Abfahrt")
                                TrackView(string: "Bahnsteig", track: station.track)
                                Spacer()
                            }
                            Divider()
                        }
                    }
                }
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
            .padding()
            
            
            HStack {
                VStack {
                    HStack {
                        Label("Nächster Halt", systemImage: "arrow.right")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text(trainStateManager.combinedState!.nextStation.name.de!)
                            .font(.title2)
                        Spacer()
                    }
                    
                    TimeEventView(timeEvent: trainStateManager.combinedState!.nextStation.arrival, eventType: "Ankunft")
                    
                    TimeEventView(timeEvent: trainStateManager.combinedState!.nextStation.departure, eventType: "Abfahrt")
                    
                    TrackView(string: "Bahnsteig", track: trainStateManager.combinedState!.nextStation.track)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
                .foregroundStyle(.black)
                
                HStack {
                    Spacer()
                    Text("I am here")
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
                .foregroundStyle(.black)
                
            }
            .padding()
            
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
                    Map(bounds: MapCameraBounds(minimumDistance: 500, maximumDistance: nil)) {
                        Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.latitude)!, longitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition!.longitude)!))
                        {
                            Text("🚄")
                                .padding()
                        }
                    }
                    
                } else {
                    Text("Der Zug stellt momentan keine GPS Info zur Verfügung :(")
                }
                
            }
            .frame(minHeight: 400)
            .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
            .foregroundStyle(.black)
            .padding()
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    InfoView()
}

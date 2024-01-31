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
                    Label("Nächster Halt", systemImage: "arrow.right")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                
                Divider()
                
                HStack {
                    VStack {
                        Text(trainStateManager.combinedState!.nextStation.name.de!)
                            .font(.title2)
                        Grid(alignment: .leading) {
                            GridRow {
                                timeEventLabel(for: .text("Ankunft"))
                                timeEventTime(for: trainStateManager.combinedState!.nextStation.arrival)
                            }
                            GridRow {
                                timeEventLabel(for: .text("Abfahrt"))
                                timeEventTime(for: trainStateManager.combinedState!.nextStation.departure)
                            }
                            GridRow {
                                trackLabel(for: "Bahnsteig")
                                trackNumber(for: trainStateManager.combinedState!.nextStation.track)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    Divider()
                    
                    VStack {
                        Text("Anschlüsse")
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
            .foregroundStyle(.black)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            
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
                                    .font(.subheadline)
                                
                                Grid(alignment: .leading) {
                                    GridRow {
                                        timeEventLabel(for: .arrival)
                                        timeEventTime(for: trainStateManager.combinedState!.nextStation.arrival)
                                    }
                                    GridRow {
                                        timeEventLabel(for: .departure)
                                        timeEventTime(for: trainStateManager.combinedState!.nextStation.departure)
                                    }
                                }
                            }
                            Divider()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            
            
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
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
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

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
            Text(trainStateManager.combinedState!.destination.de!.utf8DecodedString())
        }
        
        Text("\(trainStateManager.combinedState!.latestStatus.speed) km/h")
            .padding()
        
        ScrollView {
            HStack {
                GeometryReader { geo in
                    VStack {
                        HStack {
                            Label("Nächster Halt", systemImage: "arrow.right")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        HStack {
                            Text(trainStateManager.combinedState!.nextStation.name.de!.utf8DecodedString())
                                .font(.title2)
                            Spacer()
                        }
                        HStack {
                            Text("Ankunft")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Spacer()
                            if trainStateManager.combinedState!.nextStation.arrival.scheduled == trainStateManager.combinedState!.nextStation.arrival.forecast {
                                Text(trainStateManager.combinedState!.nextStation.arrival.scheduled)
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            } else {
                                Text(trainStateManager.combinedState!.nextStation.arrival.scheduled)
                                    .font(.caption2)
                                    .strikethrough()
                                Text(trainStateManager.combinedState!.nextStation.arrival.forecast)
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        }
                        HStack {
                            Text("Abfahrt")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Spacer()
                            if trainStateManager.combinedState!.nextStation.departure.scheduled == trainStateManager.combinedState!.nextStation.departure.forecast {
                                Text(trainStateManager.combinedState!.nextStation.departure.scheduled)
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            } else {
                                Text(trainStateManager.combinedState!.nextStation.departure.scheduled)
                                    .font(.caption2)
                                    .strikethrough()
                                Text(trainStateManager.combinedState!.nextStation.departure.forecast)
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        }
                        HStack {
                            Text("Bahnsteig")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Spacer()
                            Text(trainStateManager.combinedState!.nextStation.track.de!.utf8DecodedString())
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("Wir kommen in etwa \(trainStateManager.combinedState!.nextStationProgress) Minuten an.")
                                .multilineTextAlignment(.leading)
                                .font(.caption)
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width, height: geo.size.width)
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor).aspectRatio(1, contentMode: .fill))
                    .foregroundStyle(.black)
                    .onAppear {
                        smallSquareSideLength = geo.size.width
                    }
                }
            
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        Text("I am here")
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.width)
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor).aspectRatio(1, contentMode: .fill))
                    .foregroundStyle(.black)
                    .onAppear {
                        smallSquareSideLength = geo.size.width
                    }
                }
            }
            .frame(height: smallSquareSideLength)
            .padding()
            
            HStack {
                GeometryReader { geo in
                    Map(bounds: MapCameraBounds(minimumDistance: 500, maximumDistance: nil)) {
                        Annotation("Zug", coordinate: CLLocationCoordinate2D(latitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition.latitude)!, longitude: Double(trainStateManager.combinedState!.latestStatus.gpsPosition.longitude)!))
                        {
                            Text("🚄")
                                .padding()
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.width)
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.green).aspectRatio(1, contentMode: .fill))
                    .foregroundStyle(.black)
                    .onAppear {
                        bigSquareSideLength = geo.size.width
                    }
                }
            }
            .frame(height: bigSquareSideLength)
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

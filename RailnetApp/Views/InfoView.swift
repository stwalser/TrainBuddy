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
    @State var smallSquareSideLength: CGFloat = .zero
    @State var bigSquareSideLength: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            HStack {
                Text(trainStateManager.combinedState!.startStation)
                Text("→")
                Text(trainStateManager.combinedState!.destination.de)
            }
            
            Text("\(trainStateManager.combinedState!.latestStatus.speed) km/h")
                .padding()
            
            
            HStack {
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        Text("I am here")
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.width)
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.green).aspectRatio(1, contentMode: .fill))
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
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.green).aspectRatio(1, contentMode: .fill))
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
                    .mapControls {
                        MapScaleView()
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

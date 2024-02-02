//
//  NextStationsView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI

struct NextStationsView: View {
    @EnvironmentObject var trainStateManager: TrainStateManager
    
    var body: some View {
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
                            
                            Grid(alignment: .center) {
                                GridRow {
                                    attributeLabel(for: .arrival)
                                    timeText(for: station.arrival)
                                }
                                GridRow {
                                    attributeLabel(for: .departure)
                                    timeText(for: station.departure)
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
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    NextStationsView()
}

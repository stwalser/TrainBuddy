//
//  NextStationsView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI

struct NextStationsView: View {
    @State var trainStateManager: TrainStateManager
    
    var body: some View {
        VStack {
            SectionTitle("Nächste Halte")
                        
            ScrollView(.horizontal) {
                HStack {
                    ForEach(trainStateManager.trainState!.relevantStations) {station in
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
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Spacer()
        }
    }
}

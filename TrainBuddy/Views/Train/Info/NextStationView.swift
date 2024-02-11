//
//  NextStationView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI

struct NextStationView: View {
    @State var trainStateManager: TrainStateManager
    
    var body: some View {
        VStack {
            SectionTitle("Nächster Halt")
            
            HStack {
                SingleInfo(main: trainStateManager.combinedState!.nextStation.name.de!, caption: "")
                
                if let track = trainStateManager.combinedState!.nextStation.track {
                    Divider()
                        .frame(height: 40)
                    
                    SingleInfo(main: track.de!, caption: "Bahnsteig")
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            HStack {
                HStack {
                    HStack {
                        timeTextBold(for: trainStateManager.combinedState!.nextStation.arrival)
                        Text("An")
                        
                        Spacer()
                    }
                }
                
                Divider()
                    .frame(height: 40)
                
                HStack {
                    HStack {
                        timeTextBold(for: trainStateManager.combinedState!.nextStation.departure)
                        Text("Ab")
                        
                        Spacer()
                    }
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            SubsectionTitle("Anschlüsse")
                        
            VStack {
                if let connections = trainStateManager.combinedState!.nextStation.connections {
                    Grid {
                        ForEach(connections) { connection in
                            GridRow {
                                HStack {
                                    if connection.reachable != "yes" {
                                        Image(systemName: "clock.badge.exclamationmark")
                                            .foregroundStyle(Color(.red))
                                    }
                                    Text("\(connection.type) \(connection.lineNumber)")
                                        .font(.subheadline)
                                }
                                Text(connection.destination.de!)
                                    .font(.subheadline)
                            }
                            GridRow {
                                attributeLabel(for: .text("Abfahrt"))
                                timeText(for: connection.departure)
                            }
                            GridRow {
                                attributeLabel(for: .text("Bahnsteig"))
                                trackNumber(for: connection.track)
                            }
                            if let comment = connection.comment {
                                GridRow {
                                    attributeLabel(for: .text("Kommentar"))
                                    stringText(comment)
                                }
                            }
                            
                            Divider()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                } else {
                    Text("Noch nicht verfügbar")
                }
            }
        }
    }
}

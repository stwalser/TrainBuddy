//
//  NextStationView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 31.01.24.
//

import SwiftUI

struct NextStationView: View {
    @EnvironmentObject var trainStateManager: TrainStateManager
    
    var body: some View {
        VStack {
            HStack {
                Label("Nächster Halt", systemImage: "arrow.forward.to.line")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(trainStateManager.combinedState!.nextStation.name.de!)
                        .font(.title2)
                    Grid(alignment: .leading) {
                        GridRow {
                            attributeLabel(for: .text("Ankunft"))
                            timeText(for: trainStateManager.combinedState!.nextStation.arrival)
                        }
                        GridRow {
                            attributeLabel(for: .text("Abfahrt"))
                            timeText(for: trainStateManager.combinedState!.nextStation.departure)
                        }
                        GridRow {
                            attributeLabel(for: .text("Bahnsteig"))
                            trackNumber(for: trainStateManager.combinedState!.nextStation.track)
                        }
                        if let exitSide = trainStateManager.combinedState!.nextStation.exitSide {
                            GridRow {
                                attributeLabel(for: .text("Ausstieg"))
                                stringText(exitSide)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                                    
                Divider()
                
                VStack {
                    if let connections = trainStateManager.combinedState!.nextStation.connections {
                        VStack {
                            ForEach(connections) { connection in
                                HStack {
                                    if connection.reachable != "yes" {
                                        Image(systemName: "clock.badge.exclamationmark")
                                            .foregroundStyle(Color(.red))
                                        
                                        Spacer()
                                    }
                                    
                                    Grid {
                                        GridRow {
                                            Text("\(connection.type) \(connection.lineNumber)")
                                                .font(.subheadline)
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
                                    }
                                }
                                
                                Divider()
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    } else {
                        Text("Noch nicht verfügbar")
                    }
                    
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .background(RoundedRectangle(cornerRadius: 5.0).fill(tileColor))
        .foregroundStyle(.black)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

//
//  TimeEventView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 30.01.24.
//

import SwiftUI

@ViewBuilder func timeEventTime(for timeEvent: Time) -> some View {
    if timeEvent.scheduled == timeEvent.forecast {
        Text(timeEvent.scheduled)
            .font(.caption)
    } else {
        Text(timeEvent.scheduled)
            .font(.caption2)
            .strikethrough()
        Text(timeEvent.forecast ?? "N/A")
            .font(.caption)
            .foregroundStyle(.orange)
       
    }
}

@ViewBuilder func timeEventLabel(for eventType: EventType) -> some View {
    switch eventType {
    case .arrival:
        Image(systemName: "square.and.arrow.down")
            .rotationEffect(Angle(degrees: 270))
            .font(.caption)
            .foregroundStyle(.gray)
    case .departure:
        Image(systemName: "square.and.arrow.up")
            .rotationEffect(Angle(degrees: 90))
            .font(.caption)
            .foregroundStyle(.gray)
    case .text(let string):
        Text(string)
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

enum EventType {
    case arrival
    case departure
    case text(String)
}

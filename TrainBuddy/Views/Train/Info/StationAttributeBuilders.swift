//
//  TimeEventView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 30.01.24.
//

import SwiftUI

@ViewBuilder func timeText(for timeEvent: Time) -> some View {
    if timeEvent.scheduled == timeEvent.forecast {
        Text(timeEvent.scheduled)
            .font(.caption)
    } else {
        if timeEvent.scheduled != "" {
            Text(timeEvent.scheduled)
                .font(.caption2)
                .strikethrough()
            Text(timeEvent.forecast ?? "N/A")
                .font(.caption)
                .foregroundStyle(.orange)
        }
    }
}

@ViewBuilder func timeTextBold(for timeEvent: Time) -> some View {
    if timeEvent.scheduled == timeEvent.forecast {
        Text(timeEvent.scheduled)
            .font(.system(.title2, weight: .bold))
    } else {
        if timeEvent.scheduled != "" {
            Text(timeEvent.scheduled)
                .font(.system(.title2, weight: .bold))
                .strikethrough()
            Text(timeEvent.forecast ?? "N/A")
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(.orange)
        }
    }
}

@ViewBuilder func attributeLabel(for attribute: AttributeType) -> some View {
    switch attribute {
    case .arrival:
        Text("An")
            .font(.caption)
            .foregroundStyle(.gray)
    case .departure:
        Text("Ab")
            .font(.caption)
            .foregroundStyle(.gray)
    case .text(let string):
        Text(string)
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

@ViewBuilder func trackNumber(for track: MultiLang?) -> some View {
    if let track = track {
        Text(track.de ?? "N/A")
            .font(.caption)
    } else {
        Text("N/A")
            .font(.caption)
    }
}

@ViewBuilder func stringText(_ string: String) -> some View {
    Text(string)
        .font(.caption)
}

enum AttributeType {
    case arrival
    case departure
    case text(String)
}

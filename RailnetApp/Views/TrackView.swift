//
//  TrackView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 30.01.24.
//

import SwiftUI

@ViewBuilder func trackLabel(for string: String) -> some View {
    Text(string)
        .font(.caption)
        .foregroundStyle(.gray)
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


//
//  TrackView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 30.01.24.
//

import SwiftUI

struct TrackView: View {
    let string: String
    let track: MultiLang?
    
    var body: some View {
        HStack {
            Text(string)
                .font(.caption)
                .foregroundStyle(.gray)
            Spacer()
            if let track = self.track {
                Text(track.de ?? "N/A")
                    .font(.caption)
            } else {
                Text("N/A")
                    .font(.caption)
            }
        }
    }
}


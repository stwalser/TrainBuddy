//
//  TimeEventView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 30.01.24.
//

import SwiftUI

struct TimeEventView: View {
    let timeEvent: Time
    let eventType: String
    
    var body: some View {
        HStack {
            Text(eventType)
                .font(.caption)
                .foregroundStyle(.gray)
            
            Spacer()
            
            if timeEvent.scheduled == timeEvent.forecast {
                Text(timeEvent.scheduled)
                    .font(.caption)
                    .foregroundStyle(.green)
            } else {
                Text(timeEvent.scheduled)
                    .font(.caption2)
                    .strikethrough()
                Text(timeEvent.forecast ?? "N/A")
                    .font(.caption)
                    .foregroundStyle(.orange)
               
            }
        }
    }
}

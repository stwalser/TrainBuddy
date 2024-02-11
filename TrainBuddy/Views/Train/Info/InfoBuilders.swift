//
//  InfoBuilders.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 11.02.24.
//

import SwiftUI

@ViewBuilder func SectionTitle(_ title: String) -> some View {
    HStack {
        Text(title)
            .foregroundStyle(Color(red: 164/256, green: 52/256, blue: 58/256))
            .font(.system(.title3, weight: .bold))
        
        Spacer()
    }
    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
}

@ViewBuilder func SubsectionTitle(_ title: String) -> some View {
    HStack {
        Text(title)
            .foregroundStyle(Color(red: 164/256, green: 52/256, blue: 58/256))
            .font(.system(.subheadline, weight: .bold))
        
        Spacer()
    }
    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 10))
}

@ViewBuilder func SingleInfo(main: String, caption: String) -> some View {
    HStack {
        Text(main)
            .font(.system(.title2, weight: .bold))
        
        Text(caption)
        
        Spacer()
    }
}

//
//  WiFiFoundView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct WiFiFoundView: View {
    var body: some View {
        VStack {            
            Spacer()
            
            Image(systemName: "checkmark")
            Text("Railnet wurde gefunden.")
                .bold()
                .padding()
            Text("Daten werden geladen...")
                .bold()
            
            Spacer()
        }
        .navigationTitle("TrainBuddy")
        .containerRelativeFrame([.horizontal, .vertical])
        .background(backgroundColor)
    }
}

#Preview {
    WiFiFoundView()
}

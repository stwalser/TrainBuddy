//
//  TrainBuddyWidgetBundle.swift
//  TrainBuddyWidget
//
//  Created by Stefan Walser on 03.02.24.
//

import WidgetKit
import SwiftUI

let titleColor = Color(red: 164/256, green: 52/256, blue: 58/256)

@main
struct TrainBuddyWidgetBundle: WidgetBundle {
    var body: some Widget {
//        TrainBuddyWidget()
        TrainBuddyWidgetLiveActivity()
    }
}

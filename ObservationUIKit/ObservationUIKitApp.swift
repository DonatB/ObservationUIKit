//
//  ObservationUIKitApp.swift
//  ObservationUIKit
//
//  Created by Ptera on 1/23/25.
//

import SwiftUI

@main
struct ObservationUIKitApp: App {
    var body: some Scene {
        WindowGroup {
//            CounterView(model: CounterModel())
            
            UIViewControllerRepresenting {
                CounterViewController(model: CounterModel())
            }
        }
    }
}

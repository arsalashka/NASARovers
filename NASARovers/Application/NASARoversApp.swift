//
//  NASARoversApp.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

@main
struct NASARoversApp: App {
    var body: some Scene {
        WindowGroup {
            RoverSelectionView(viewModel: RoverSelectionViewModel(for: .curiosity))
//            RoverView(viewModel: RoverSelectionViewModel(for: .curiosity))
//            TestView()
        }
    }
}

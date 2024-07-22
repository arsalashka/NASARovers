//
//  View + clipSegment.swift
//  NASARovers
//
//  Created by Arsalan on 14.07.2024.
//

import SwiftUI

extension View {
    func clipSegment(for rover: Rover, and selectedRover: Rover) -> some View {
        modifier(ClipAnimatedShape(rover: rover, selectedRover: selectedRover))
    }
}

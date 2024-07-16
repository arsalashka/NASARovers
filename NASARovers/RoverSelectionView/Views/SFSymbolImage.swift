//
//  SFSymbolImage.swift
//  NASARovers
//
//  Created by Arsalan on 16.07.2024.
//

import Foundation
import SwiftUI

struct SFSymbolImage: View {
    let systemName: String
    
    var body: some View {
        return Image(systemName: systemName)
            .renderingMode(.template)
            .frame(width: 20, height: 20)
    }
}

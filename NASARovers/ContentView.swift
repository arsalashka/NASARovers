//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

struct ContentView: View {
    let apiDataProvider = APIDataProvider()
    
    init() {
        apiDataProvider.getData(for: .manifests(rover: .curiosity)) { (data: Manifest) in
            print(data.photoManifest.photos.count)
        } errorHandler: { error in
            print(error.description)
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

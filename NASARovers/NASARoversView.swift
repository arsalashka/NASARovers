//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

struct NASARoversView: View {
    private let apiDataProvider = APIDataProvider()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear() {
            apiDataProvider.getData(for: .manifests(rover: .curiosity)) { (data: Manifest) in
                print(data.photoManifest.photos.count)
            } errorHandler: { error in
                print(error.description)
            }
        }
        .padding()
    }
}

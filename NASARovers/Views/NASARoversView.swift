//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

struct NASARoversView: View {
    @ObservedObject var viewModel: PhotoViewModel
    
    var body: some View {
        ZStack {
            Color($viewModel.photoDict.wrappedValue.isEmpty ? .white : .green)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .onAppear(perform: viewModel.bind)
            .padding()
        }
    }
}

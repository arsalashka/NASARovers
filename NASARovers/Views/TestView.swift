//
//  TestView.swift
//  NASARovers
//
//  Created by Arsalan on 22.07.2024.
//

import SwiftUI

struct TestView: View {
    @State private var showingCredits = true

    var body: some View {
//        Button("Show Credits") {
//            showingCredits.toggle()
//        }
        Text("some text")
        .sheet(isPresented: $showingCredits) {
            Text("This app was brought to you by Hacking with Swift")
                .interactiveDismissDisabled()
                .presentationDetents([.height(UIScreen.height * 0.05), .height(UIScreen.main.bounds.height * 0.75)])
        }
    }
}

#Preview {
    TestView()
}

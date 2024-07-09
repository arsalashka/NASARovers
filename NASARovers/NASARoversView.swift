//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

struct NASARoversView: View {
    private let photoProvider: PhotosProvider
    
    init(for rover: Rover) {
        self.photoProvider = PhotosProviderImpl(for: rover)
        
        photoProvider.fetchPhoto { [self] dict in
            print(dict.count, "\n\n")
            
            self.photoProvider.fetchPhoto { [self] dict in
                print(dict.count, "\n\n")
                
                self.photoProvider.fetchPhoto { [self] dict in
                    print(dict.count, "\n\n")
                    
                    self.photoProvider.fetchPhoto { [self] dict in
                        print(dict.count, "\n\n")
                        
                        self.photoProvider.fetchPhoto { dict in
                            print(dict.count, "\n\n")
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
//        .onAppear() {
//            apiDataProvider.getData(for: .manifests(rover: .curiosity)) { (data: Manifest) in
//                print(data.photoManifest.photos.count)
//            } errorHandler: { error in
//                print(error.description)
//            }
//        }
        .padding()
    }
}

//
//  RoverView.swift
//  NASARovers
//
//  Created by Arsalan on 20.07.2024.
//

import SwiftUI

enum RoverViewConstants: String {
    case curiosityBackground
    case xMark = "xmark"
    case nasaMarsRover = "Nasa Mars Rover"
}

struct RoverView: View {
    @ObservedObject var viewModel: RoverSelectionViewModel
    
    var body: some View {
        ZStack {
            Image(RoverViewConstants.curiosityBackground.rawValue)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(UIScreen.width, UIScreen.height)
            
            VStack {
                HStack {
                    Text(viewModel.selectedRover.rawValue.uppercased())
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button {
                        print("Button Taped")
                    } label: {
                        SFSymbolImage(systemName: RoverViewConstants.xMark.rawValue)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .font(.system(size: 24, weight: .regular))
                            .padding(.trailing, 3)
                    }
                }
                
                Text(RoverViewConstants.nasaMarsRover.rawValue)
                    .font(.system(size: 17, weight: .bold))
                    .padding(.horizontal, 16)
                    .frame(width: UIScreen.width, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 80) {
                    if let roverInfo = viewModel.roverInfo {
                        RoverMainInfoView(name: "Day", value: roverInfo.day)
                        RoverMainInfoView(name: "Sol", value: roverInfo.sol)
                        RoverMainInfoView(name: "Photos", value: roverInfo.photos)
                    }
                }
                .padding(.bottom, 60)
            }
            .shadow(color: .black, radius: 5, x: 2, y: 3)
            .safeAreaPadding(.top, 30)
        }
        .onAppear {
            viewModel.bind()
        }
    }
}

fileprivate struct RoverMainInfoView: View {
    let name, value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.system(size: 18, weight: .semibold))
            Text(name)
                .font(.system(size: 16, weight: .light))
        }
        .foregroundColor(.white)
    }
}

#Preview {
    RoverView(viewModel: RoverSelectionViewModel(for: .curiosity))
}

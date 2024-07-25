//
//  RoverView.swift
//  NASARovers
//
//  Created by Arsalan on 20.07.2024.
//

import SwiftUI

private enum RoverViewConstants: String {
    case curiosityBackground
    case xMark = "xmark"
    case nasaMarsRover = "Nasa Mars Rover"
}

private enum BottomSheetDetentValue: CGFloat {
    case low = 0.1
    case high = 0.8
}

struct RoverView: View {
    private var RoverMainInfoViewOffset: CGFloat {
        if detent == .fraction(BottomSheetDetentValue.low.rawValue) {
            return UIScreen.height * 0.1 + 60
        } else if detent == .fraction(BottomSheetDetentValue.high.rawValue) {
            return UIScreen.height * 0.8
        }
        return 0
    }
    
    @ObservedObject var viewModel: RoverSelectionViewModel
    @State private var isBottomSheetPresented = true
    @State private var detent: PresentationDetent = .fraction(0.1)
    
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
                    RoverMainInfoView(name: "Day", value: viewModel.roverInfo.day)
                    RoverMainInfoView(name: "Sol", value: viewModel.roverInfo.sol)
                    RoverMainInfoView(name: "Photos", value: viewModel.roverInfo.photos)
                }
                .animation(.bouncy, value: RoverMainInfoViewOffset)
                .padding(.bottom, RoverMainInfoViewOffset)
            }
            .shadow(color: .black, radius: 5, x: 2, y: 3)
            .safeAreaPadding(.top, 30)

            
            BottomSheet(detent: $detent)
            
        }
    }
}
        
//  MARK: - BottomSheet
fileprivate struct BottomSheet: View {
    @State var presentSheet = true
    @Binding var detent: PresentationDetent
    
    var body: some View {
        Text("")
            .sheet(isPresented: $presentSheet) {
                Text("Custom Bottom Sheet")
                    .interactiveDismissDisabled()
                    .presentationDetents(
                        [.fraction(BottomSheetDetentValue.low.rawValue),
                         .fraction(BottomSheetDetentValue.high.rawValue)],
                        selection: $detent
                    )
            }
    }
}

//  MARK: - RoverMainInfoView
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

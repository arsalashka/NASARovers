//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

private enum RoverSelectionViewConstants: String {
    case fetchPhotoFromRover = "Fetch photo from rover"
    case fetchAll = "fetch All"
    case calendar = "calendar"
    case mission = "mission"
    case more = "more"
    case ellipsisCircle = "ellipsis.circle"
}

//  MARK: - RoverSelectionView
struct RoverSelectionView: View {
    @ObservedObject var viewModel: RoverSelectionViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        ForEach(Rover.allCases, id: \.self) { rover in
                            Image(rover.rawValue)
                                .resizable()
                                .scaledToFit()
                                .clipSegment(for: rover, and: viewModel.selectedRover)
                                .onTapGesture {
                                    withAnimation { viewModel.selectedRover = rover }
                                }
                        }
                    }
                    .frame(UIScreen.width, UIScreen.width * 1.25)
                    
                    Text(RoverSelectionViewConstants.fetchPhotoFromRover.rawValue.uppercased())
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .font(.system(size: 12))
                        .frame(width: UIScreen.width, alignment: .leading)
                        .foregroundColor(.black)
                    
                    TabView(selection: $viewModel.selectedRover) {
                        ForEach(Rover.allCases, id: \.self) {
                            RoverInfoView(rover: $0, viewModel: viewModel)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
                    .frame(width: UIScreen.width, height: 250)
                }
                Spacer()
                    .height(100)
            }
            VStack {
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Text(RoverSelectionViewConstants.fetchAll.rawValue.uppercased())
                            .font(.system(size: 15, weight: .bold) )
                            .frame(width: UIScreen.width - 200)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .backgroundColor(.blue)
                    .frame(height: 50)
                    .clipCapsule()
                    
                    Button {
                        
                    } label: {
                        SFSymbolImage(systemName: RoverSelectionViewConstants.calendar.rawValue)
                            .scaledToFill()
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                    }
                    .backgroundColor(.blue)
                    .frame(height: 50)
                    .clipCapsule()
                }
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: -3)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(.all)
//        .onAppear {
//            viewModel.bind()
//        }
    }
}

//  MARK: - RoverInfoView
fileprivate struct RoverInfoView: View {
    var rover: Rover
    var viewModel: RoverSelectionViewModel
    
    var body: some View {
        VStack {
            Text(rover.rawValue.uppercased())
                .font(.system(size: 32, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.black)
            
            Text(RoverSelectionViewConstants.mission.rawValue.uppercased())
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 16)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.gray)
            
            Text(viewModel.getMissionInfo(for: rover))
                .font(.system(size: 12, weight: .semibold))
                .padding(.top, 3)
                .padding(.horizontal, 16)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.gray)
                .lineLimit(10)
            
            Button {
                
            } label: {
                HStack {
                    Text(RoverSelectionViewConstants.more.rawValue.uppercased())
                        .font(.system(size: 12))
                    
                    SFSymbolImage(systemName: RoverSelectionViewConstants.ellipsisCircle.rawValue)
                }
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 16)
            .frame(width: UIScreen.width, alignment: .trailing)
            
            Spacer()
        }
    }
    
    
}

//  MARK: - ClipAnimatedShape
struct ClipAnimatedShape: ViewModifier {
    var rover: Rover
    var selectedRover: Rover
    
    func body(content: Content) -> some View {
        let offset: CGFloat = rover == selectedRover ? UIScreen.width * 0.025 : 0
        
        switch rover {
        case .curiosity:
            content
                .clipShape(CuriositySegment())
                .contentShape(CuriositySegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .animation(.linear(duration: 0.15))
                .offset(offset * 0.07, -offset * 1.2)
        case .opportunity:
            content
                .clipShape(OpportunitySegment())
                .contentShape(OpportunitySegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .animation(.linear(duration: 0.15))
                .offset(-offset * 0.2, -offset * 1.3)
        case .spirit:
            content
                .clipShape(SpiritSegment())
                .contentShape(SpiritSegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .animation(.linear(duration: 0.15))
                .offset(-offset * 4, -offset * 5)
        }
    }
}

#Preview {
    RoverSelectionView(viewModel: RoverSelectionViewModel(for: .opportunity))
}

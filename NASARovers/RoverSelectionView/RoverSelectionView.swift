//
//  ContentView.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import SwiftUI

extension UIScreen {
    static let width = UIScreen.main.bounds.width
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
                    
                    Text("Fetch photo from rover".uppercased())
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .font(.system(size: 12))
                        .frame(width: UIScreen.width, alignment: .leading)
                        .foregroundColor(.black)
                    
                    TabView(selection: $viewModel.selectedRover) {
                        ForEach(Rover.allCases, id: \.self) { rover in
                            RoverInfoView(rover: rover)
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
                        Text(String(localized: "fetch All").uppercased())
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
                        Image(systemName: "calendar")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .frame(20)
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
        .onAppear {
            viewModel.bind()
        }
    }
}

//  MARK: - RoverInfoView
fileprivate struct RoverInfoView: View {
    var rover: Rover
    
    var body: some View {
        VStack {
            Text(rover.rawValue.uppercased())
                .font(.system(size: 32, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.black)
            
            Text("mission".uppercased())
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 16)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.gray)
            
            Text(getMissionInfo(for: rover))
                .font(.system(size: 12, weight: .semibold))
                .padding(.top, 3)
                .padding(.horizontal, 16)
                .frame(width: UIScreen.width, alignment: .leading)
                .foregroundColor(.gray)
                .lineLimit(10)
            
            Button {
                
            } label: {
                HStack {
                    Text("More".uppercased())
                        .font(.system(size: 12))
                    
                    Image(systemName: "ellipsis.circle")
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                }
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 16)
            .frame(width: UIScreen.width, alignment: .trailing)
            
            Spacer()
        }
    }
    
    private func getMissionInfo(for rover: Rover) -> String {
        switch rover {
        case .curiosity:
            return """
            Part of NASA's Mars Science Laboratory mission, Curiosity is the largest and most capable rover ever sent to Mars. It launched Nov. 26, 2011 and landed on Mars at 10:32 p.m.  PDT on Aug. 5, 2012 - (1:32•a.m. EDT on Aug. 6, 2012).
            
            Curiosity set out to answer the question: Did Mars ever have the right environmental conditions to support small life forms called microbes? Early in its mission, Curiosity's scientific tools found chemical and mineral evidence of past habitable environments on Mars. It continues to explore the rock record from a time when Mars could have been home to microbial life.
            """
        case .opportunity:
            return """
            Opportunity was the second of the two rovers launched in 2003 to land on Mars and begin traversing the Red Planet in search of signs of ancient water. The rover explored the Martian terrain for almost 15-years, far outlasting her planned 90-day mission.
            
            After landing on Mars in 2004, • Opportunity-made a number of discoveries about the Red Planet-including dramatic evidence that long ago at least one area of Mars stayed wet for an extended period and that conditions could have been suitable for sustaining microbial life.
            """
        case .spirit:
            return """
            One of two rovers launched in 2003 to explore Mars and search for signs of past life, Spirit far outlasted her planned 90-day mission, lasting over six years. Among her myriad discoveries, Spirit found evidence that Mars was once much wetter than it is today and helped scientists better understand the Martian wind.
            
            In May 2009, the rover became embedded-in soft soil at a site called "Troy" with only five working wheels to aid in the rescue effort. After months of testing and carefully planned maneuvers, NASA ended efforts to free the rover and eventually ended the mission on May 25, 2011.
            """
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

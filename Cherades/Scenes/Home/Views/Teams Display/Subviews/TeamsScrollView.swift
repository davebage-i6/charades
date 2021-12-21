//
//  TeamsScrollView.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

import SwiftUI

struct TeamsScrollView: View {
    
    struct Constants {
        static let spacing: CGFloat = 10
        static let padding: CGFloat = 30
        static let cardWidth: CGFloat = 300
        static let cardHeight: CGFloat = 400
    }
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            if teamsViewModel.teamCards.count == 1 {
                teamsViewModel.teamCards[0]
                    .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                    .padding(Constants.padding)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        HStack(spacing: Constants.spacing) {
                            ForEach(teamsViewModel.teamCards) { card in
                                GeometryReader { geo in
                                    card
                                        .rotation3DEffect(Angle(degrees: Double(geo.frame(in: .global).minX - 30) / -15),
                                                          axis: (x: 0, y: 10, z: 0))
                                    
                                }
                                .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                            }
                        }
                        .padding(Constants.padding)
                    }
                }
                .background(Color.clear)
                .padding()
            }
            
            AddAnotherTeamButton(homeViewModel: homeViewModel)
        }
    }
}

struct TeamsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsScrollView(teamsViewModel: TeamsViewModel(),
                        homeViewModel: HomeViewModel())
    }
}

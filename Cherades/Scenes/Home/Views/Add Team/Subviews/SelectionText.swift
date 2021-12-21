//
//  SelectionText.swift
//  Cherades
//
//  Created by Dave Bage on 07/12/2021.
//

import SwiftUI

struct SelectionText: View {
    struct Constants {
        static let spacing: CGFloat = 10
        static let fontSize: CGFloat = 20
        static let fontOpacity: CGFloat = 0.6
        static let buttonCornerRadius: CGFloat = 10
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 100
    }
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    var animate = true
    
    var body: some View {
        ZStack {
            /// If there's only one team in the DB, we need at least one more before we allow user to proceed
            if teamsViewModel.teams.count == 1 {
                Text(Strings.SelectionText.needAtLeastTwo.localized)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding()
                /// If we have more than 0  teams in the db (and we know from above we have more than 1)
            } else if teamsViewModel.teams.count > 0 {
                VStack(spacing: Constants.spacing) {
                    /// We check the number of selected teams. If it is 0...
                    if teamsViewModel.selectedTeams.count == 0 {
                        /// We asl to select 2 teams
                        Text(Strings.SelectionText.selectTwo.localized)
                            .font(.system(size: Constants.fontSize))
                            .foregroundColor(.white.opacity(Constants.fontOpacity))
                            .bold()
                            .padding(.bottom, Constants.buttonHeight)
                            .padding(.bottom)
                        /// If 1 is selected ...
                    } else if teamsViewModel.selectedTeams.count == 1 {
                        /// We ask to select 1 more
                        Text(Strings.SelectionText.selectOneMore.localized)
                            .font(.system(size: Constants.fontSize))
                            .foregroundColor(.white.opacity(Constants.fontOpacity))
                            .bold()
                            .padding(.bottom, Constants.buttonHeight)
                            .padding(.bottom)
                    } else {
                        /// If we reach here we know we have 2 teams selected so user may proceed
                        VStack {
                            Text(Strings.SelectionText.youreSet.localized)
                                .font(.system(size: Constants.fontSize))
                                .foregroundColor(.white.opacity(Constants.fontOpacity))
                                .bold()
                            
                            /// Navigation link takes us to the game interface
                            NavigationLink(destination: GameInterface(gameViewModel: GameViewModel(teams: teamsViewModel.selectedTeams), teamsViewModel: teamsViewModel)) {
                                HStack {
                                    Text(Strings.SelectionText.letsgo.localized)
                                        .foregroundColor(.white)
                                    
                                }
                                .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                                .background(Color.blue)
                                .cornerRadius(Constants.buttonCornerRadius)
                                .modifier(ShadowModifier(type: .content))
                            }
                        }
                    }
                }
                .transition(.opacity)
                .animation(.easeInOut, value: animate)
            }
        }
    }
}

struct SelectionText_Previews: PreviewProvider {
    static var previews: some View {
        SelectionText(teamsViewModel: TeamsViewModel())
    }
}

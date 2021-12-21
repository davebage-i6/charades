//
//  NextTeamButton.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import SwiftUI

struct NextTeamButton: View {
    struct Constants {
        static let iconSize: CGFloat = 60
    }
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        Button(action: {
            gameViewModel.switchActiveTeam()
        }) {
            VStack {
                Image.next
                    .font(.system(size: Constants.iconSize))
                    .foregroundColor(.pink)
            }
        }
    }
}

struct NextTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        NextTeamButton(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Team 1", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
            TeamViewModel(teamName: "Team 2", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        ]))
    }
}

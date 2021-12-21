//
//  TeamsView.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import SwiftUI

struct TeamsView: View {
    struct Constants {
        struct Title {
            static let width: CGFloat = 300
        }
        
        struct TeamsStack {
            static let spacing: CGFloat = 100
            static let photoSize: CGFloat = 100
            static let fontSize: CGFloat = 30
            static let activeFontColor = Color.white.opacity(0.7)
            static let inactiveFontColor = Color.white.opacity(0.3)
            static let timeFontSize: CGFloat = 20
            static let vSpacing: CGFloat = 20
            static let switchButtonImageSize: CGFloat = 30
            static let switchButtonTextOpacity: CGFloat = 0.5
        }
    }
    
    @ObservedObject var gameViewModel: GameViewModel
    @Binding var isTimerRunning: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: Constants.TeamsStack.spacing) {
                ForEach(gameViewModel.teams) { team in
                    VStack(spacing: Constants.TeamsStack.vSpacing) {
                        Text(team.teamName)
                            
                            .font(.system(size: Constants.TeamsStack.fontSize))
//                            .foregroundColor(team.isActive ? Constants.TeamsStack.activeFontColor : Constants.TeamsStack.inactiveFontColor)
                            .foregroundColor(team.isActive ? Constants.TeamsStack.activeFontColor : Constants.TeamsStack.inactiveFontColor)
                            .bold()
                            .fitSystemFont()
                            
                        
                        GameInterfaceTeamDisplay(team: team)
                    }
                }
            }
            
            Button {
                guard !isTimerRunning else { return }
                
                gameViewModel.activeTeam.turnsTaken += 1
                
                if !gameViewModel.activeTeam.timeOut && !gameViewModel.inActiveTeam.timeOut {
                    gameViewModel.switchActiveTeam()
                } else {
                    gameViewModel.nextButtonActive.toggle()
                    if gameViewModel.activeTeam.turnsTaken > gameViewModel.inActiveTeam.turnsTaken {
                        gameViewModel.winningTeam = gameViewModel.activeTeam
                        gameViewModel.losingTeam = gameViewModel.inActiveTeam
                        gameViewModel.gameOver = true
                    }
                }
                
            } label: {
                VStack {
                    if !gameViewModel.activeTeam.timeOut && !gameViewModel.inActiveTeam.timeOut {
                        Image.switchUser
                            .font(.system(size: Constants.TeamsStack.switchButtonImageSize))
                            .foregroundColor(.white.opacity(isTimerRunning ? 0.4 : 1))
                        Text("Switch")
                            .foregroundColor(.white.opacity(Constants.TeamsStack.switchButtonTextOpacity))
                    } else {
                        Image.plus
                            .font(.system(size: Constants.TeamsStack.switchButtonImageSize))
                            .foregroundColor(.white.opacity(isTimerRunning || !gameViewModel.nextButtonActive ? 0.4 : 1))
                        Text("Next go")
                            .foregroundColor(.white.opacity(Constants.TeamsStack.switchButtonTextOpacity))
                    }
                }
                
            }
            .disabled(isTimerRunning || !gameViewModel.nextButtonActive)
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Team 1", teamPhoto: Image("Sophia1"), stars: 3, id: UUID()),
            TeamViewModel(teamName: "Team 2", teamPhoto: Image("Sophia1"), stars: 3, id: UUID())
        ]), isTimerRunning: .constant(false))
    }
}

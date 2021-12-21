//
//  WinnerView.swift
//  Cherades
//
//  Created by Dave Bage on 15/12/2021.
//

import SwiftUI

struct WinnerView: View {
    @ObservedObject var gameViewModel: GameViewModel
    let winningTeam: TeamViewModel?

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 15) {
                if let winningTeam = winningTeam {
                    winningTeam.teamPhoto
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 100)
                        .modifier(ShadowModifier(type: .image))
                    
                    Text("\(winningTeam.teamName) wins")
                        .bold()
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .fitSystemFont()
                    
                    Text("Cherades completed:")
                        .foregroundColor(.white)
                        .fitSystemFont()
                    Text("\(winningTeam.turnsTaken) vs \(gameViewModel.losingTeam?.turnsTaken ?? 0)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .bold()
                        .fitSystemFont()
                } else {
                    Text("It's a draw!")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    Image.draw
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                }
                
            }
            .frame(width: 200, height: 300)
            .background(Color.pink)
            .cornerRadius(20)
            .modifier(ShadowModifier(type: .content))
            
            if gameViewModel.isDraw {
                Image.drawIcon
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .offset(y: -40)
            } else {
                Image.star
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                    .offset(y: -40)
            }
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Team x", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
            TeamViewModel(teamName: "Team y", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        ]), winningTeam: TeamViewModel(teamName: "Team x", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()))
    }
}

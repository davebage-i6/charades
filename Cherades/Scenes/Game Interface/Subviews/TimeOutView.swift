//
//  TimeOutView.swift
//  Cherades
//
//  Created by Dave Bage on 16/12/2021.
//

import SwiftUI

struct TimeOutView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                Text("\(gameViewModel.inActiveTeam.teamName) has run out of time!").bold()
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .fitSystemFont()
                gameViewModel.activeTeam.teamPhoto
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100)
                    .modifier(ShadowModifier(type: .image))
                VStack(alignment: .leading, spacing: 10) {
                    Text("Cherades completed: \(gameViewModel.inActiveTeam.turnsTaken)").bold()
                        .fitSystemFont()
                    Text("\(gameViewModel.activeTeam.teamName) has \(Int(gameViewModel.activeTeam.timeRemaining)) seconds left to beat \(gameViewModel.inActiveTeam.turnsTaken) cherades!")
                        .fitSystemFont()
                }
                .padding()
                
                .font(.system(size: 20))
                .foregroundColor(.white)
                Button("OK") {
                    gameViewModel.showTimeOut = false
                    gameViewModel.nextButtonActive = false
                }
                .frame(width: 150, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .modifier(ShadowModifier(type: .content))
                .padding()
            }
            .frame(width: 300, height: 500)
            .background(Color(UIColor("#243B55")))
            .cornerRadius(20)
            .modifier(ShadowModifier(type: .content))
            Image.clock
                .font(.system(size: 60))
                .foregroundColor(.white)
                .offset(y: -30)
        }
    }
}

struct TimeOutView_Previews: PreviewProvider {
    static var previews: some View {
        TimeOutView(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Test1", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
            TeamViewModel(teamName: "Test2", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        ]))
    }
}

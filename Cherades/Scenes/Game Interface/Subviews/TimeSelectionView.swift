//
//  TimeSelectionView.swift
//  Cherades
//
//  Created by Dave Bage on 16/12/2021.
//

import SwiftUI

struct TimeSelectionView: View {
    @State private var seconds: CGFloat = 300
    @ObservedObject var gameViewModel: GameViewModel
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Select preferred game time per team")
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 20))
                    .lineLimit(3)
                VStack {
                    Slider(value: $seconds, in: 0...600)
                    Text("\(Int(seconds)) seconds")
                        .foregroundColor(.white)
                }
                .padding()
                
                Button {
                    defaults.set(seconds, forKey: "time")
                    gameViewModel.showTimerSelection = false
                    gameViewModel.teams.forEach { team in
                        team.timeRemaining = seconds
                        team.totalTime = seconds
                    }
                } label: {
                    Text("OK")
                        .frame(width: 200, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
                .cornerRadius(10)
            }
            .frame(width: 300, height: 300)
            .background(Color(UIColor("#243B55")))
            .cornerRadius(20)
            .modifier(ShadowModifier(type: .content))
            
            Image.clock
                .font(.system(size: 60))
                .foregroundColor(.white)
                .offset(y: -30)
        }
        .onAppear {
            if defaults.float(forKey: "time") != 0 {
                seconds = CGFloat(defaults.float(forKey: "time"))
            }
        }
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Test1", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
            TeamViewModel(teamName: "Test2", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        ]))
    }
}

//
//  StartStopButton.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import SwiftUI

struct StartStopButton: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    struct Constants {
        static let fontSize: CGFloat = 30
        static let buttonSize: CGFloat = 90
        static let minButtonSize: CGFloat = 50
    }
    
    @Binding var isTimerRunning: Bool
    @Binding var allowTimeChange: Bool
    
    var body: some View {
        Button(action: {
            self.isTimerRunning.toggle()
            
            if gameViewModel.teams.filter({ $0.timeOut }).count == 1 {
                gameViewModel.nextButtonActive = !isTimerRunning
            }
            
            allowTimeChange = false
        }) {
            HStack {
                if isTimerRunning {
                    Image.stop
                        .font(.system(size: Constants.fontSize))
                } else {
                    Image.play
                        .font(.system(size: Constants.fontSize))
                }
            }
            
            .frame(maxWidth: Constants.buttonSize, maxHeight: Constants.buttonSize)
            .frame(minWidth: Constants.minButtonSize, minHeight: Constants.minButtonSize)
            .background(isTimerRunning ? Color.red : Color.green)
            .clipShape(Circle())
            .foregroundColor(.white)
            .modifier(ShadowModifier(type: .content))
            .animation(.easeInOut, value: isTimerRunning)
        }
    }
}

struct StartStopButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "Test1", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
            TeamViewModel(teamName: "Test2", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        ]), isTimerRunning: .constant(false), allowTimeChange: .constant(true))
    }
}

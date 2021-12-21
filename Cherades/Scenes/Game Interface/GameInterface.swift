//
//  GameInterface.swift
//  Cherades
//
//  Created by Dave Bage on 07/12/2021.
//

/// Main container view for game interface

import SwiftUI

struct GameInterface: View {
    
    struct Constants {
        static let teamsViewPadding: CGFloat = 10
    }
    
    /// View models observed
    @ObservedObject var gameViewModel: GameViewModel
    @ObservedObject var teamsViewModel: TeamsViewModel
    @State var showInfo = false
    @State var allowTimerChange = true
    
    @Environment(\.dismiss) var dismiss
    
    /// State variables
    @State var isTimerRunning = false
    
    /// Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            ZStack {
                    LinearGradient(colors: [
                        Color.black,
                        Color(UIColor("#0f2027")),
                        Color(UIColor("#203a43")),
                        Color(UIColor("#2c5364"))
                    ],
                                   startPoint: .top,
                                   endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        /// Container for teams display
                        TeamsView(gameViewModel: gameViewModel, isTimerRunning: $isTimerRunning)
//                            .padding(.top, Constants.teamsViewPadding)
                        
                        Spacer()
                        
                        /// Progress view for timer
                        RingView(teamViewModel: gameViewModel.activeTeam)
                        
                        Spacer()
                        
                        /// Start / stop button view
                        StartStopButton(gameViewModel: gameViewModel, isTimerRunning: $isTimerRunning, allowTimeChange: $allowTimerChange)
                            .padding()
                        
                        Spacer()
                        /// Suggestions button and view
                        SuggestionsButton()
                        
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .onReceive(timer) { _ in
                        if isTimerRunning, !gameViewModel.gameOver {
                            gameViewModel.timerAction()
                            if gameViewModel.tempStop {
                                isTimerRunning = false
                                gameViewModel.tempStop = false
                            }
                        } else {
                            if gameViewModel.gameOver {
                                isTimerRunning = false
                                allowTimerChange = true
                            }
                        }
                    }
                    
                    if gameViewModel.winningTeam != nil || gameViewModel.isDraw {
                        BlurView(style: .regular)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1))
                        
                        WinnerView(gameViewModel: gameViewModel, winningTeam: gameViewModel.winningTeam)
                            .transition(.slide)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                            .onTapGesture {
                                gameViewModel.resetGame()
                                teamsViewModel.teams.forEach { team in
                                    team.isSelected = false
                                }
                                teamsViewModel.selectedTeams = []
                                dismiss()
                            }
                    }
                    
                    if gameViewModel.showTimeOut {
                        BlurView(style: .regular)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1))
                        
                        TimeOutView(gameViewModel: gameViewModel)
                            .transition(.slide)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    }
                    
                    if gameViewModel.showTimerSelection {
                        BlurView(style: .regular)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1))
                        TimeSelectionView(gameViewModel: gameViewModel)
                            .transition(.slide)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    }
                    
                    if showInfo {
                        BlurView(style: .regular)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1))
                            .onTapGesture {
                                showInfo = false
                            }
                        
                        InstructionsView()
                            .transition(.slide)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    }
                }
                .frame(maxHeight: screen.height)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            gameViewModel.showTimerSelection = true
                        } label: {
                            Image.clock
                                .font(.system(size: 20))
                                .foregroundColor(.white.opacity(allowTimerChange ? 1 : 0.4))
                        }
                        .disabled(!allowTimerChange)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showInfo.toggle()
                        } label: {
                            Image.info
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
                .onAppear {
                    if UserDefaults.standard.float(forKey: "time") == 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            gameViewModel.showTimerSelection = true
                        }
                    }
            }
        }
        .frame(maxHeight: screen.height)
    }
}

struct GameInterface_Previews: PreviewProvider {
    static var previews: some View {
        GameInterface(gameViewModel: GameViewModel(teams: [
            TeamViewModel(teamName: "The cool team yeah man totally", teamPhoto: Image("Sophia1"), stars: 3, id: UUID()),
            TeamViewModel(teamName: "The cool team yeah man totally", teamPhoto: Image("Sophia1"), stars: 3, id: UUID())
        ]), teamsViewModel: TeamsViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                        .previewDisplayName("iPhone 8")
    }
}

extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

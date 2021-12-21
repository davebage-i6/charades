//
//  ContentView.swift
//  Cherades
//
//  Created by Dave Bage on 18/11/2021.
//

/// Main content container view

import SwiftUI

struct ContentView: View {
    
    struct Constants {
        static let blurAnimationDuration: CGFloat = 0.4
        
        struct AddPlayersForm {
            static let formOffset: CGFloat = 1000
            
            struct Animation {
                static let response: CGFloat = 0.5
                static let damping: CGFloat = 0.6
                static let duration: CGFloat = 1
            }
        }
    }
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var teamsViewModel = TeamsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
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
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Image.title
                        
                        Spacer()
                        
                        SelectionText(teamsViewModel: teamsViewModel) /// View which appears once teams added and configured based on number of teams contained
                        
                        TeamDisplayView(teamsViewModel: self.teamsViewModel, homeViewModel: self.homeViewModel) /// View which displays the team cards in a scroll view
                            .padding()
                        
                        Spacer()
                    }
                }
                
                if teamsViewModel.deleteRequested {
                    BlurView(style: .regular)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.5))
                        .edgesIgnoringSafeArea(.all)
                    if let teamToDelete = teamsViewModel.teamToDelete {
                        DeleteConfirmationView(teamViewModel: teamToDelete, teamsViewModel: teamsViewModel)
                            .transition(.slide)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                    }
                }
                
                if homeViewModel.showAddPlayerForm {
                    BlurView(style: .regular)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 0.5))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            homeViewModel.showAddPlayerForm = false
                        }
                }
                
                AddTeamForm(teamsViewModel: teamsViewModel, homeViewModel: self.homeViewModel)
                    .animation(Animation.spring(
                        response: Constants.AddPlayersForm.Animation.response,
                        dampingFraction: Constants.AddPlayersForm.Animation.damping,
                        blendDuration: Constants.AddPlayersForm.Animation.duration), value: homeViewModel.showAddPlayerForm)
                    .offset(y: homeViewModel.showAddPlayerForm ? 0 : Constants.AddPlayersForm.formOffset)
            }
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                        .previewDisplayName("iPhone 8")
        
        ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                    .previewDisplayName("iPhone 11")
        
        ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                    .previewDisplayName("iPhone 11 Pro")
        
        ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                    .previewDisplayName("iPhone 12 Pro Max")
        
        ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
                    .previewDisplayName("iPhone 13")
    }
}

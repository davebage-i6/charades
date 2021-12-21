//
//  TeamDisplayView.swift
//  Cherades
//
//  Created by Dave Bage on 03/12/2021.
//

import SwiftUI

struct TeamDisplayView: View {
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            if !teamsViewModel.teams.isEmpty {
                TeamsScrollView(teamsViewModel: teamsViewModel, homeViewModel: homeViewModel) /// Teams scroll view
                
            } else {
                AddTeamStack(homeViewModel: self.homeViewModel)
            }
        }
    }
}


struct TeamDisplayView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TeamDisplayView(
                teamsViewModel: TeamsViewModel(),
                homeViewModel: HomeViewModel())
            
            TeamDisplayView(
                teamsViewModel: TeamsViewModel(),
                homeViewModel: HomeViewModel())
            
            TeamDisplayView(
                teamsViewModel: TeamsViewModel(),
                homeViewModel: HomeViewModel())
        }
    }
}

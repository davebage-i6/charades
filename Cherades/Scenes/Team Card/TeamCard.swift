//
//  TeamCard.swift
//  Cherades
//
//  Created by Dave Bage on 18/11/2021.
//

import SwiftUI

struct TeamCard: View, Identifiable {
    struct Constants {
        static let vSpacing: CGFloat = 20
        static let width: CGFloat = 300
        static let height: CGFloat = 400
        static let cornerRadius: CGFloat = 30
        static let checkMarkSize: CGFloat = 50
    }
    
    @ObservedObject var teamViewModel: TeamViewModel
    @ObservedObject var teamsViewModel: TeamsViewModel
    
    let id = UUID()
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .topLeading) {
                    VStack {
                        VStack {
                            TeamPhoto(teamViewModel: teamViewModel)
                        }
                        .frame(width: Constants.width, height: 200)
                        
                        StatsView(teamViewModel: teamViewModel)
                            .padding(.bottom)
                        
                    }
                    .frame(width: Constants.width, height: Constants.height)
                    .background(LinearGradient(colors: [Color(UIColor("F7EFC0")), Color(UIColor("D6BC71")), Color(UIColor("9D7F31"))], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(Constants.cornerRadius)
                    .modifier(ShadowModifier(type: .text))
                    TheatreMasks()
                }
                
                if self.teamViewModel.isSelected {
                    Image.check
                        .font(.system(size: Constants.checkMarkSize))
                        .foregroundColor(.white)
                }
            }
            .onTapGesture {
                if teamsViewModel.selectedTeams.count < 2 && !self.teamViewModel.isSelected {
                    teamsViewModel.selectedTeams.append(self.teamViewModel)
                    self.teamViewModel.isSelected = true
                } else if self.teamViewModel.isSelected {
                    teamsViewModel.selectedTeams.removeAll { team in
                        team.id == teamViewModel.id
                    }
                    self.teamViewModel.isSelected = false
                }
            }
            Button {
                teamsViewModel.deleteRequested = true
                teamsViewModel.teamToDelete = self.teamViewModel
                
            } label: {
                Image.trash
                    .offset(x: 5, y: 5)
                    .font(.system(size: 30))
                    .foregroundColor(Color(UIColor("45390B")))
            }
            
        }
    }
}

struct TeamCard_Previews: PreviewProvider {
    static var previews: some View {
        TeamCard(teamViewModel: TeamViewModel(
            teamName: "The Bagesjh",
            teamPhoto: Image("Sophia1"),
            stars: 3, id: UUID()), teamsViewModel: TeamsViewModel())
    }
}

struct StatsView: View {
    @ObservedObject var teamViewModel: TeamViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text(teamViewModel.teamName)
                .font(.custom("FiraSans-Regular", size: 30))
                .foregroundColor(Color(UIColor("45390B")))
                .fitSystemFont()
            
            Rectangle()
                .frame(width: 200, height: 1)
                .foregroundColor(Color(UIColor("45390B")))
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Games played:")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                    Text("10")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                }
                
                HStack {
                    Text("Wins:")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                    Text("3")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                }
                
                HStack {
                    Text("Losses:")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                    Text("4")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                }
                
                HStack {
                    Text("Draws:")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                    Text("3")
                        .font(.custom("FiraSans-Regular", size: 20))
                        .foregroundColor(Color(UIColor("45390B")))
                }
            }
        }
        .frame(width: 300, height: 200)
    }
}

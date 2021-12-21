//
//  SubmitNewTeamButton.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

/// Button used to add a new team and store to core data

import SwiftUI

struct SubmitNewTeamButton: View {
    struct Constants {
        static let titleVPadding: CGFloat = 5
        static let titleHPadding: CGFloat = 20
        static let buttonRadius: CGFloat = 10
    }
    
    @ObservedObject var teamsViewModel: TeamsViewModel /// We use this to add a new team and store to core data
    @ObservedObject var addTeamViewModel: AddTeamViewModel /// We use this to access the photo from the camera
    @ObservedObject var homeViewModel: HomeViewModel /// We use this to dismiss the form
    @Binding var teamName: String
    
    var body: some View {
        Button(action: {
            guard let uiImage = self.addTeamViewModel.imageAdded else { return }
            
            self.teamsViewModel.addTeam(team: TeamViewModel(
                teamName: self.teamName,
                teamPhoto: Image(uiImage: uiImage),
                stars: 0,
                id: UUID()))
            
            self.homeViewModel.showAddPlayerForm = false
            self.addTeamViewModel.imageAdded = nil /// Reset form
            self.teamName = "" /// Reset form
            
        }) {
            Text("Add team")
                .foregroundColor(.white.opacity(teamName.isEmpty || addTeamViewModel.imageAdded == nil ? 0.3 : 1))
                .padding(.vertical, Constants.titleVPadding)
                .padding(.horizontal, Constants.titleHPadding)
        }
        .background(Color.blue.opacity(teamName.isEmpty || addTeamViewModel.imageAdded == nil ? 0.3 : 1))
        .cornerRadius(Constants.buttonRadius)
        .modifier(ShadowModifier(type: .text))
        .disabled(teamName.isEmpty || addTeamViewModel.imageAdded == nil)
    }
}

struct SubmitNewTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitNewTeamButton(
            teamsViewModel: TeamsViewModel(),
            addTeamViewModel: AddTeamViewModel(),
            homeViewModel: HomeViewModel(),
            teamName: .constant(""))
    }
}

//
//  AddTeamForm.swift
//  Cherades
//
//  Created by Dave Bage on 26/11/2021.
//

import SwiftUI
import UIKit

struct AddTeamForm: View {
    struct Constants {
        static let vSpacing: CGFloat = 20
        
        struct Container {
            static let width: CGFloat = 300
            static let height: CGFloat = 400
            static let cornerRedius: CGFloat = 30
        }
        
        struct Icon {
            static let fontSize: CGFloat = 60
            static let yOffset: CGFloat = -25
        }
    }
    
    @State var teamName = ""
    
    @ObservedObject var teamsViewModel: TeamsViewModel
    @ObservedObject var addTeamViewModel = AddTeamViewModel()
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: Constants.vSpacing) {
                    HStack {
                        Text("Add a team")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.title)
                            .bold()
                            .padding(.top)
                    }
                    
                    TeamPhotoPlaceHolder(addTeamViewModel: self.addTeamViewModel)
                    AddTeamTextField(teamName: $teamName)
                    SubmitNewTeamButton(teamsViewModel: teamsViewModel, addTeamViewModel: addTeamViewModel, homeViewModel: homeViewModel, teamName: $teamName)
                }
                Image.close
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .offset(y: -40)
                    .onTapGesture {
                        homeViewModel.showAddPlayerForm = false
                    }
                }
                .frame(width: Constants.Container.width, height: Constants.Container.height)
                .background(Color(UIColor("#243B55")))
                .cornerRadius(Constants.Container.cornerRedius)
                .modifier(ShadowModifier(type: .content))
            .padding()
            
            Image.plus
                .foregroundColor(.white)
                .font(.system(size: Constants.Icon.fontSize))
                .offset(y: Constants.Icon.yOffset)
        }
    }
}

struct AddTeamForm_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamForm(teamsViewModel: TeamsViewModel(), homeViewModel: HomeViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}

//
//  AddTeamTextField.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

/// Textfield allowing user to enter a team name

import SwiftUI

struct AddTeamTextField: View {
    struct Constants {
        static let width: CGFloat = 280
        static let height: CGFloat = 60
        static let cornerRadius: CGFloat = 10
        static let opacity: CGFloat = 0.6
    }
    
    @Binding var teamName: String
    
    var body: some View {
        ZStack {
            TextField(
                "Team name",
                text: $teamName,
                prompt: Text("Enter team name").foregroundColor(.black.opacity(Constants.opacity)))
                .padding()
        }
        .background(Color.white.opacity(0.6))
        .cornerRadius(Constants.cornerRadius)
        .padding()
        .frame(width: Constants.width, height: Constants.height)
        .modifier(ShadowModifier(type: .text))
    }
}

struct AddTeamTextField_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamTextField(teamName: .constant(""))
    }
}

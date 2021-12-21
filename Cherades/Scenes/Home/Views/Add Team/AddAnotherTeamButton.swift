//
//  AddAnotherTeamButton.swift
//  Cherades
//
//  Created by Dave Bage on 02/12/2021.
//

/// Button which allows users to open the add team form from the home page

import SwiftUI

struct AddAnotherTeamButton: View {
    struct Constants {
        static let fontSize: CGFloat = 30
        static let cornerRadius: CGFloat = 10
    }
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Button(action: {
            homeViewModel.showAddPlayerForm = true
        }) {
            HStack {
                Image.plus
                    .font(.system(size: Constants.fontSize))
                    .foregroundColor(.white)
                Text("Add another team")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(Constants.cornerRadius)
        }
    }
}

struct AddAnotherTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        AddAnotherTeamButton(homeViewModel: HomeViewModel())
    }
}

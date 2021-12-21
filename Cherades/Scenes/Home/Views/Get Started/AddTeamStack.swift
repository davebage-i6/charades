//
//  AddTeamStack.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import SwiftUI

struct AddTeamStack: View {
    struct Constants {
        static let fontSize: CGFloat = 15
        static let padding: CGFloat = 30
    }
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            VStack {
                Text("You're all alone :(")
                    .foregroundColor(.white)
                    .bold()
                Text("Add a team to get started")
                    .foregroundColor(.white)
                    .font(.system(size: Constants.fontSize))
                AddTeamView(homeViewModel: homeViewModel)
            }
            Spacer()
        }
        .padding(.top, Constants.padding)
    }
}


struct AddTeamStack_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamStack(homeViewModel: HomeViewModel())
    }
}

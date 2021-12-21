//
//  TeamPhoto.swift
//  Cherades
//
//  Created by Dave Bage on 26/11/2021.
//

import SwiftUI

struct TeamPhoto: View {
    
    struct Constants {
        static let photoSize: CGFloat = 120
        static let backgroundWidth: CGFloat = 300
        static let backgroundHeight: CGFloat = 200

        struct BackgroundCard {
            static let cornerRadius: CGFloat = 5
            static let rotationDegrees: CGFloat = 10
        }
    }
    
    @ObservedObject var teamViewModel: TeamViewModel
    
    var body: some View {
        ZStack {
            Image("skulls")
                .resizable()
                .frame(width: Constants.backgroundWidth, height: Constants.backgroundHeight)
                .aspectRatio(contentMode: .fill)
            VStack(spacing: 0) {
                Stars(teamViewModel: teamViewModel)
                    .padding()
                teamViewModel.teamPhoto
                    .resizable()
                    .frame(width: Constants.photoSize, height: Constants.photoSize)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                .clipShape(Circle())
                Spacer()
                Rectangle()
                    .frame(width: Constants.backgroundWidth, height: 1)
                    .foregroundColor(Color(UIColor("45390B")))
            }
        }
    }
}

struct TeamPhoto_Previews: PreviewProvider {
    static var previews: some View {
        TeamPhoto(teamViewModel: TeamViewModel(teamName: "The cool dudes", teamPhoto: Image("Sophia1"), stars: 3, id: UUID()))
    }
}

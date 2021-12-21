//
//  GameInterfaceTeamDisplay.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import SwiftUI

struct GameInterfaceTeamDisplay: View {
    
    struct Constants {
        static let photoSize: CGFloat = 100
        static let circleOffset: CGFloat = 10
        static let controllerSize: CGFloat = 30
        static let controllerYOffset: CGFloat = -20
        static let inactiveTeamOpacity: CGFloat = 0.2
        static let photoCoverOpacity: CGFloat = 0.8
        static let color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        static let color2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    @ObservedObject var team: TeamViewModel
    
    var body: some View {
        VStack {
            ZStack {
                RingView(
                    color1: Constants.color1.withAlphaComponent(team.isActive ? 1 : 0.2),
                    color2: Constants.color2.withAlphaComponent(team.isActive ? 1 : 0.2),
                    width: Constants.photoSize + Constants.circleOffset,
                    height: Constants.photoSize + Constants.circleOffset,
                    teamViewModel: team)
                
                ZStack(alignment: .top) {
                    team.teamPhoto
                        .resizable()
                        .frame(width: Constants.photoSize, height: Constants.photoSize)
                        .clipShape(Circle())
                    if team.isActive {
                        Image.controller
                            .font(.system(size: Constants.controllerSize))
                            .foregroundColor(.white)
                            .offset(y: Constants.controllerYOffset)
                    }
                }
                
                if !team.isActive {
                    Circle()
                        .fill(Color.black.opacity(Constants.photoCoverOpacity))
                        .frame(width: Constants.photoSize, height: Constants.photoSize)
                }
            }
            HStack {
                Image.theatreMasks
                    .foregroundColor(.white)
                Text("x\(team.turnsTaken)")
                    .foregroundColor(.white)
            }
        }
    }
}

struct GameInterfaceTeamDisplay_Previews: PreviewProvider {
    static var previews: some View {
        let team = TeamViewModel(teamName: "Test team", teamPhoto: Image("Sophia1"), stars: 2, id: UUID())
        GameInterfaceTeamDisplay(team: team)
    }
}

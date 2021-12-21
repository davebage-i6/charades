//
//  Stars.swift
//  Cherades
//
//  Created by Dave Bage on 26/11/2021.
//

import SwiftUI

struct Stars: View {
    @ObservedObject var teamViewModel: TeamViewModel
    
    var body: some View {
        HStack {
            ForEach(teamViewModel.starArray) { star in
                star.starImage()
                    .foregroundColor(Color(UIColor("45390B")))
                    .modifier(ShadowModifier(type: .image))
            }
        }
    }
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars(teamViewModel: TeamViewModel(teamName: "test", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()))
    }
}

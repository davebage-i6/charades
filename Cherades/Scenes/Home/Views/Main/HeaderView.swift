//
//  HeaderView.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import SwiftUI

struct HeaderView: View {
    struct Constants {
        static let font: Font = .custom("PermanentMarker-Regular", size: 60)
        
        struct TheatreMasks {
            static let size: CGFloat = 100
            static let color = Color.black.opacity(0.7)
        }
    }
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Image.theatreMasks
                .font(.system(size: Constants.TheatreMasks.size))
                .foregroundColor(Constants.TheatreMasks.color)
                .modifier(ShadowModifier(type: .image))
            
            Text("Cheradios")
                .font(Constants.font)
                .foregroundColor(.white)
                .modifier(ShadowModifier(type: .text))
            
            AddTeamView(homeViewModel: homeViewModel)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(homeViewModel: HomeViewModel())
    }
}

//
//  TheatreMasks.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

import SwiftUI

struct TheatreMasks: View {
    struct Constants {
        static let fontSize: CGFloat = 40
        static let rotationAngle: CGFloat = -40
        static let xOffset: CGFloat = -20
        static let yOffset: CGFloat = -10
    }
    
    var body: some View {
        
        Image.theatreMasks
            .font(.system(size: Constants.fontSize))
            .rotationEffect(Angle(degrees: Constants.rotationAngle))
            .offset(x: Constants.xOffset, y: Constants.yOffset)
            .foregroundColor(Color(UIColor("45390B")))
            .modifier(ShadowModifier(type: .image))
    }
}

struct TheatreMasks_Previews: PreviewProvider {
    static var previews: some View {
        TheatreMasks()
    }
}

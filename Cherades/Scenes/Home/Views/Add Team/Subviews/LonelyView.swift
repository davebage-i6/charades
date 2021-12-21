//
//  LonelyView.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

import SwiftUI

struct LonelyView: View {
    struct Constants {
        static let opacity: CGFloat = 0.7
        static let width: CGFloat = 150
    }
    
    var body: some View {
        Image.lonely
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.purple.opacity(Constants.opacity))
            .frame(width: Constants.width)
    }
}


struct LonelyView_Previews: PreviewProvider {
    static var previews: some View {
        LonelyView()
    }
}

//
//  Modifiers.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import SwiftUI

enum ContentType {
    case image
    case icon
    case content
    case text
}

struct ShadowModifier: ViewModifier {
    let type: ContentType
    
    func body(content: Content) -> some View {
        switch type {
        case .image:
            content
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 12)
                .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 1)
        case .icon:
            content
                .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.4), radius: 1, x: 0, y: 1)
        case .content:
            content
                .shadow(color: Color.black.opacity(0.4), radius: 9, x: 0, y: 9)
                .shadow(color: Color.black.opacity(0.4), radius: 1, x: 0, y: 1)
        case .text:
            content
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
        }
    }
}

//
//  SuggestionDisplay.swift
//  Cherades
//
//  Created by Dave Bage on 15/12/2021.
//

import SwiftUI

struct SuggestionDisplay: View {
    struct Constants {
        static let textContainerSize: CGFloat = 300
        static let textContainerHeight: CGFloat = 100
        static let fontSize: CGFloat = 20
    }
    
    @Binding var suggestion: Suggestion?
    
    var body: some View {
        ZStack {
            Image.banner
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                .modifier(ShadowModifier(type: .content))
            VStack {
                suggestion?.type.icon()
                Text(suggestion?.name ?? "?")
                    .foregroundColor(.white)
                    .font(.custom("PermanentMarker-Regular", size: Constants.fontSize))
                    .bold()
                    .fitSystemFont()
                    
            }
            .padding()
            .frame(width: Constants.textContainerSize, height: Constants.textContainerHeight)
            .foregroundColor(.white)
            .font(.custom("PermanentMarker-Regular", size: Constants.fontSize))
        }
    }
}

struct SuggestionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionDisplay(suggestion: .constant(Suggestion(name: "Nightmare on Elm Street", type: .movie, ageType: .adult)))
    }
}

public struct FitSystemFont: ViewModifier {
    public var lineLimit: Int?
    public var fontSize: CGFloat?
    public var minimumScaleFactor: CGFloat
    public var percentage: CGFloat

    public func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .font(.system(size: min(min(geometry.size.width, geometry.size.height) * percentage, fontSize ?? CGFloat.greatestFiniteMagnitude)))
                .lineLimit(self.lineLimit)
                .minimumScaleFactor(self.minimumScaleFactor)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
}

public extension View {
    func fitSystemFont(lineLimit: Int? = nil, fontSize: CGFloat? = nil, minimumScaleFactor: CGFloat = 0.01, percentage: CGFloat = 1) -> ModifiedContent<Self, FitSystemFont> {
        return modifier(FitSystemFont(lineLimit: lineLimit, fontSize: fontSize, minimumScaleFactor: minimumScaleFactor, percentage: percentage))
    }
}

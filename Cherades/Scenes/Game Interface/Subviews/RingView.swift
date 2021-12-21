//
//  RingView.swift
//  Cherades
//
//  Created by Dave Bage on 07/12/2021.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 200
    var height: CGFloat = 200
    
    @ObservedObject var teamViewModel: TeamViewModel
    
    var body: some View {
        let multiplier = width / 44
        
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(maxWidth: width, maxHeight: height)
                .frame(minWidth: width - 50, minHeight: height - 50)
            Circle()
                .trim(from: 1 - self.teamViewModel.percent, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(maxWidth: width, maxHeight: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            Text("\(Int(teamViewModel.timeRemaining))")
                .font(.system(size: 14 * multiplier))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .modifier(ShadowModifier(type: .content))
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(teamViewModel: TeamViewModel(teamName: "Test", teamPhoto: Image("Sophia1"), stars: 3, id: UUID()))
    }
}

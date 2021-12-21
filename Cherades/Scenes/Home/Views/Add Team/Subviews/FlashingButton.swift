//
//  FlashingButton.swift
//  Cherades
//
//  Created by Dave Bage on 06/12/2021.
//

import SwiftUI

struct FlashingButton: View {
    
    struct Constants {
        static let opacity1: CGFloat = 0.4
        static let opacity2: CGFloat = 0.2
        static let startRadius: CGFloat = 400
        static let endRadius: CGFloat = 600
        static let buttonSize: CGFloat = 200
        static let innerButtonSize: CGFloat = 100
        static let plusButtonAdjustment: CGFloat = 10
        static let animationDuration: Double = 1.2
    }
    
    @ObservedObject var homeViewModel: HomeViewModel
    @State var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.blue.opacity(Constants.opacity1), Color.white.opacity(Constants.opacity2)],
                        center: .center,
                        startRadius: Constants.startRadius,
                        endRadius: Constants.endRadius)
                )
                .frame(maxWidth: Constants.buttonSize, maxHeight: Constants.buttonSize)
                

            Button(action: {
                homeViewModel.showAddPlayerForm.toggle()
            }) {
                Image.plus
                    .foregroundColor(.white)
                    .font(.system(size: Constants.innerButtonSize - Constants.plusButtonAdjustment))
            }
            .frame(maxWidth: Constants.innerButtonSize, maxHeight: Constants.innerButtonSize)
            .background(Color.blue)
            .clipShape(Circle())
        }
    }
}

struct FlashingButton_Previews: PreviewProvider {
    static var previews: some View {
        FlashingButton(homeViewModel: HomeViewModel())
    }
}

//
//  InstructionsView.swift
//  Cherades
//
//  Created by Dave Bage on 17/12/2021.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Instructions")
                    .bold()
                    .font(.system(size: 30))
                
                Text("1. The first player receives either a film, show or book to act out, either from using the 'Get suggestion' button, or by receiving one from a member of the opposite team.")
                
                Text("2. When the acting player begins, the start button must be hit and the countdown will begin.")
                
                Text("3. Once the player's teammate(s) has successfully guessed what he / she is acting, the 'Switch' button should be used to move to the next team.")
                
                Text("4. Keep playing in this way until one team has run out of time. At this point, they are out and only the other team may continue. After each successful cherade completed by the remaining team, the 'Next' button should be used to increment the team score.")
                
                Text("5. Whichever team secures the most successful cherades wins. If the one remaining team secures more than the other team's score before their time has expired, they win instantly.")
            }
            .padding()
        }
        .frame(width: 400, height: 600)
        .background(Color(UIColor("#243B55")))
        .cornerRadius(20)
        .modifier(ShadowModifier(type: .content))
        .foregroundColor(.white)
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}

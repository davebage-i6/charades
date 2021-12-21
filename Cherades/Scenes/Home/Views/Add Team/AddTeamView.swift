//
//  AddTeamView.swift
//  Cherades
//
//  Created by Dave Bage on 26/11/2021.
//

import SwiftUI

struct AddTeamView: View {
    struct Constants {
        static let padding: CGFloat = 40
    }
    
    @State var animate = true
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var showingImagePicker = false
    
    var body: some View {
        ZStack {
            HStack {
                LonelyView()
                
                FlashingButton(homeViewModel: homeViewModel)
            }
            .frame(maxWidth: screen.width - 20)
            .padding()
        }
    }
}

struct AddTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamView(homeViewModel: HomeViewModel())
    }
}

let screen = UIScreen.main.bounds

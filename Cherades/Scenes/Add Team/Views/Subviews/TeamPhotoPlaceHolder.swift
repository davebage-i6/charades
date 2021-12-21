//
//  TeamPhotoPlaceHolder.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

/// Placeholder camera view for the add team button on the add team form

import SwiftUI

struct TeamPhotoPlaceHolder: View {
    struct Constants {
        static let cornerRadius: CGFloat = 10
        static let circleSize: CGFloat = 28
        static let imageFontSize: CGFloat = 30
    }
    
    @ObservedObject var addTeamViewModel: AddTeamViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            CameraButton(addTeamViewModel: addTeamViewModel)
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: Constants.circleSize, height: Constants.circleSize)
                
                if addTeamViewModel.imageAdded == nil {
                    Image.plus
                        .font(.system(size: Constants.imageFontSize))
                        .foregroundColor(.blue)
                } else {
                    Image.edit
                        .font(.system(size: Constants.imageFontSize))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct TeamPhotoPlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        TeamPhotoPlaceHolder(addTeamViewModel: AddTeamViewModel())
    }
}

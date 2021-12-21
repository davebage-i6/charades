//
//  CameraButton.swift
//  Cherades
//
//  Created by Dave Bage on 03/12/2021.
//

/// Button which takes users to the camera to add a team photo

import SwiftUI

struct CameraButton: View {
    struct Constants {
        static let cameraSize: CGFloat = 40
        static let cameraOpacity: CGFloat = 0.4
        static let height: CGFloat = 110
        static let width: CGFloat = 100
    }
    
    @State var openCameraRoll = false
    @State var imageSelected: UIImage?
    @ObservedObject var addTeamViewModel: AddTeamViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                self.openCameraRoll = true
            }) {
                if let imageSelected = addTeamViewModel.imageAdded {
                    Image(uiImage: imageSelected)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image.camera
                        .font(.system(size: Constants.cameraSize))
                        .foregroundColor(.black.opacity(Constants.cameraOpacity))
                }
                
            }
        }
        .frame(width: Constants.width, height: Constants.height)
        .background(Color.white)
        .clipShape(Circle())
        .modifier(ShadowModifier(type: .content))
        .sheet(isPresented: $openCameraRoll) {
            ImagePicker(addTeamViewModel: addTeamViewModel, selectedImage: $imageSelected)
        }
    }
}

struct CameraButton_Previews: PreviewProvider {
    static var previews: some View {
        CameraButton(addTeamViewModel: AddTeamViewModel())
    }
}

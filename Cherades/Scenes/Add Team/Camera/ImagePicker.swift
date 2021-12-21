//
//  ImagePicker.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    @ObservedObject var addTeamViewModel: AddTeamViewModel
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        picker.sourceType = self.sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, addTeamViewModel: self.addTeamViewModel)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    struct Constants {
        static let imageQuality: CGFloat = 0.1
    }
    
    let parent: ImagePicker
    @ObservedObject var addTeamViewModel: AddTeamViewModel
    
    init(_ parent: ImagePicker, addTeamViewModel: AddTeamViewModel) {
        self.parent = parent
        self.addTeamViewModel = addTeamViewModel
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            guard let data = image.jpegData(compressionQuality: Constants.imageQuality), let compressedImage = UIImage(data: data) else {
                return
            }
            
            parent.selectedImage = compressedImage
            self.addTeamViewModel.imageAdded = compressedImage
        }
        
        parent.presentationMode.wrappedValue.dismiss()
    }
}

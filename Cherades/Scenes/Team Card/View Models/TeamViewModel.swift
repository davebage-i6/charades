//
//  TeamViewModel.swift
//  Cherades
//
//  Created by Dave Bage on 26/11/2021.
//

import SwiftUI
import CoreData
import Combine

enum TeamNumber: Int {
    case one = 1
    case two = 2
}

struct Star: Identifiable {
    let id = UUID()
    let filled: Bool
    
    func starImage() -> Image {
        return filled ? Image.filledStar : Image.star
    }
}

class TeamViewModel: ObservableObject, Identifiable {
    let context = PersistenceController.shared.container.viewContext
    var id: UUID
    let teamName: String
    let teamPhoto: Image
    let defaults = UserDefaults.standard
    
    @Published var stars: Int
    @Published var isActive = false
    @Published var teamNumber: TeamNumber?
    @Published var totalTime: CGFloat = 300
    @Published var timeRemaining: CGFloat = 300
    @Published var percent: CGFloat = 1
    @Published var isSelected = false
    @Published var starArray = [Star]()
    @Published var turnsTaken = 0
    @Published var timeOut = false
    
    var cancellables = Set<AnyCancellable>()
    
    init(teamName: String, teamPhoto: Image, stars: Int, id: UUID) {
        self.teamName = teamName
        self.teamPhoto = teamPhoto
        self.stars = stars
        self.id = id
        
        $timeRemaining
            .sink { timeRemaining in
                self.percent = CGFloat(self.timeRemaining / self.totalTime)
                if timeRemaining < 1 {
                    self.timeOut = true
                    print("Time out")
                }
            }
            .store(in: &self.cancellables)
        
        $stars
            .sink { stars in
                self.starArray = []
                for _ in 0..<stars {
                    self.starArray.append(Star(filled: true))
                }
                
                for _ in 0..<5 - stars {
                    self.starArray.append(Star(filled: false))
                }
            }
            .store(in: &self.cancellables)
        
        if UserDefaults.standard.float(forKey: "time") != 0 {
            self.totalTime = CGFloat(UserDefaults.standard.float(forKey: "time"))
            self.timeRemaining = CGFloat(UserDefaults.standard.float(forKey: "time"))
        }
    }
    
    func mapToCoreData() {
        let storedTeam = TeamCD(context: context)
        
        storedTeam.teamName = self.teamName
        storedTeam.stars = Int16(self.stars)
        storedTeam.id = self.id
        
        /// Image conversion
        let img = self.teamPhoto.asUIImage()
        let png = img.pngData()
        storedTeam.teamPhoto = png
        
        PersistenceController.shared.save()
    }
    
    static func mapFromCoreData(team: TeamCD) -> TeamViewModel {
        var teamPhoto = Image("Cheradios")
        
        if let photo = team.teamPhoto, let img = UIImage(data: photo) {
            teamPhoto = Image(uiImage: img)
        }
        
        return TeamViewModel(
            teamName: team.teamName ?? "No name",
            teamPhoto: teamPhoto,
            stars: Int(team.stars),
            id: team.id ?? UUID()
        )
    }
}

extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//
//  RingViewModel.swift
//  Cherades
//
//  Created by Dave Bage on 07/12/2021.
//

import SwiftUI
import Combine

class RingViewModel: ObservableObject {
    @Published var totalTime: CGFloat = 300
    @Published var timeRemaining: CGFloat = 300
    @Published var percent: CGFloat = 1
    
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        $timeRemaining
            .sink { timeRemaining in
                self.percent = CGFloat(self.timeRemaining / self.totalTime)
            }
            .store(in: &self.cancellables)
    }
}

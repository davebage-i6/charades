//
//  GameViewModel.swift
//  Cherades
//
//  Created by Dave Bage on 10/12/2021.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class GameViewModel: ObservableObject {
    @Published var teams: [TeamViewModel]
    @Published var gameOver = false
    @Published var activeTeam: TeamViewModel
    @Published var inActiveTeam: TeamViewModel
    @Published var winningTeam: TeamViewModel?
    @Published var losingTeam: TeamViewModel?
    @Published var tempStop = false
    @Published var isDraw = false
    @Published var showTimeOut = false
    @Published var showTimerSelection = false
    @Published var nextButtonActive = true
    
    var cancellables = Set<AnyCancellable>()
    
    init(teams: [TeamViewModel]) {
        self.teams = teams
        self.activeTeam = teams[0]
        self.inActiveTeam = teams[1]
        
        $activeTeam
            .sink { team in
                teams.forEach {
                    if $0.id == team.id {
                        $0.isActive = true
                    } else {
                        $0.isActive = false
                        self.inActiveTeam = $0
                    }
                }
            }
            .store(in: &self.cancellables)
        
        $winningTeam
            .sink { winningTeam in
                guard let winner = winningTeam, winner.stars < 5 else { return }
                let winnerID = winner.id
                let predicate = NSPredicate(format: "id == %@", winnerID.uuidString)
                
                winner.stars += 1
                PersistenceController.shared.context.fetchAll(TeamCD.self, predicate: predicate, sorting: nil)[0].stars += 1
                PersistenceController.shared.save()
            }
            .store(in: &self.cancellables)
        
        $losingTeam
            .sink { losingTeam in
                guard let loser = losingTeam, loser.stars > 0 else { return }
                let loserID = loser.id
                let predicate = NSPredicate(format: "id == %@", loserID.uuidString)
                loser.stars -= 1
                PersistenceController.shared.context.fetchAll(TeamCD.self, predicate: predicate, sorting: nil)[0].stars -= 1
                PersistenceController.shared.save()
            }
            .store(in: &self.cancellables)
    }
    
    func switchActiveTeam() {
        if teams[0].isActive {
            self.activeTeam = teams[1]
        } else {
            self.activeTeam = teams[0]
        }
    }
    
    func timerAction() {
        if activeTeam.timeOut && inActiveTeam.timeOut {
            if activeTeam.turnsTaken > inActiveTeam.turnsTaken {
                self.winningTeam = activeTeam
                self.losingTeam = inActiveTeam
                gameOver = true
            } else if activeTeam.turnsTaken < inActiveTeam.turnsTaken {
                self.winningTeam = inActiveTeam
                self.losingTeam = inActiveTeam
                gameOver = true
            } else {
                self.isDraw = true
                gameOver = true
            }
        } else {
            if activeTeam.timeOut {
                guard activeTeam.turnsTaken >= inActiveTeam.turnsTaken else {
                    self.winningTeam = inActiveTeam
                    self.losingTeam = activeTeam
                    gameOver = true
                    return
                }
                tempStop = true
                showTimeOut = true
                switchActiveTeam()
            } else if activeTeam.turnsTaken > inActiveTeam.turnsTaken && inActiveTeam.timeOut {
                self.winningTeam = activeTeam
                self.losingTeam = inActiveTeam
                gameOver = true
            } else {
                if activeTeam.timeRemaining > 0 {
                    activeTeam.timeRemaining -= 1
                }
            }
        }
    }
    
    func stopGamePrematurely() {
        
    }
    
    func resetGame() {
        self.gameOver = false
        self.winningTeam = nil
        self.losingTeam = nil
        self.teams.forEach { team in
            team.timeRemaining = team.totalTime
            team.percent = 1
            team.timeOut = false
            team.turnsTaken = 0
        }
    }
}

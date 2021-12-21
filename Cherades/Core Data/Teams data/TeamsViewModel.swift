//
//  TeamsViewModel.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import SwiftUI
import Combine

class TeamsViewModel: ObservableObject, Identifiable {
    let context = PersistenceController.shared.container.viewContext
    @Published var teams = [TeamViewModel]()
    @Published var teamCards = [TeamCard]()
    var id = UUID()
    var cancellables = Set<AnyCancellable>()
    @Published var selectedTeams = [TeamViewModel]()
    @Published var teamToDelete: TeamViewModel?
    @Published var cardToDelete: TeamCard?
    @Published var deleteRequested = false
    
    init() {
        getAllTeams()
        
        $teams
            .sink { teams in
                self.teamCards = []
                teams.forEach { team in
                    self.teamCards.append(TeamCard(
                        teamViewModel: team,
                        teamsViewModel: self))
                }
            }
            .store(in: &self.cancellables)
    }
    
    func getAllTeams() {
        self.teams = [] // Reset teams view model
        PersistenceController.shared.context.fetchAll(TeamCD.self).forEach { team in
            teams.append(TeamViewModel.mapFromCoreData(team: team))
        }
    }
    
    func addTeam(team: TeamViewModel) {
        team.mapToCoreData()
        getAllTeams()
    }
}

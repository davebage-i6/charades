//
//  DeleteConfirmationView.swift
//  Cherades
//
//  Created by Dave Bage on 17/12/2021.
//

import SwiftUI

struct DeleteConfirmationView: View {
    @ObservedObject var teamViewModel: TeamViewModel
    @ObservedObject var teamsViewModel: TeamsViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .top) {
                VStack {
                    VStack {
                        Text("Are you sure you want to delete this team?")
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 25))
                        teamViewModel.teamPhoto
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .clipShape(Circle())
                        Text(teamViewModel.teamName)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.top, 40)
                    
                    Button("OK") {
                        teamsViewModel.deleteRequested = false
                        
                        teamsViewModel.teamCards.removeAll(where: {
                            $0.teamViewModel.id == teamViewModel.id
                        })
                        
                        teamsViewModel.teams.removeAll(where: {
                            $0.id == teamViewModel.id
                        })
                        
                        teamsViewModel.selectedTeams = []
                        
                        let predicate = NSPredicate(format: "id == %@", teamViewModel.id.uuidString)
                        
                        let savedTeam = PersistenceController.shared.context.fetchAll(TeamCD.self, predicate: predicate, sorting: nil)[0]
                        
                        PersistenceController.shared.context.delete(savedTeam)
                        
                        PersistenceController.shared.save()
                        
                        teamsViewModel.teamToDelete = nil
                    }
                    .frame(width: 180, height: 40)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .frame(width: 300, height: 390)
                .background(Color(UIColor("#243B55")))
                
                .cornerRadius(20)
                Image.trashCircle
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .offset(y: -40)
            }
            
            Button(action: {
                teamsViewModel.deleteRequested = false
                teamsViewModel.teamToDelete = nil
            }) {
                Image.close
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
        }
    }
}

struct DeleteConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteConfirmationView(teamViewModel: TeamViewModel(teamName: "Test1", teamPhoto: Image("Sophia1"), stars: 2, id: UUID()),
                               teamsViewModel: TeamsViewModel())
    }
}

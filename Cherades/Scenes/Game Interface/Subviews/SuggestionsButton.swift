//
//  SuggestionsButton.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import SwiftUI

struct SuggestionsButton: View {
    struct Constants {
        static let buttonCornerRadius: CGFloat = 10
    }
    
    @State var allSuggestions = Suggestions.shared.kidsMoviesList + Suggestions.shared.adultsMoviesList + Suggestions.shared.books + Suggestions.shared.shows
    
    @State var suggestion: Suggestion?
    
    var body: some View {
        VStack {
            Button(action: {
                let possibleSuggestions = self.allSuggestions.filter {
                    $0.alreadySuggested == false
                }
                
                if possibleSuggestions.count > 0 {
                    self.suggestion = possibleSuggestions[Int.random(in: 0..<possibleSuggestions.count)]
                    
                    for i in 0..<allSuggestions.count {
                        if allSuggestions[i].id == self.suggestion?.id {
                            allSuggestions[i].alreadySuggested = true
                        }
                    }
                } else {
                    self.suggestion = Suggestion(name: Strings.GameInterface.noSuggestions.localized, type: .none, ageType: .kid)
                }
            }) {
                Text(Strings.GameInterface.getSuggestion.localized)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
            }
            .background(Color.purple)
            .cornerRadius(Constants.buttonCornerRadius)
            .modifier(ShadowModifier(type: .content))
        .padding()
            SuggestionDisplay(suggestion: $suggestion)
        }
        .padding(.bottom, 40)
    }
}

struct SuggestionsButton_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsButton()
    }
}

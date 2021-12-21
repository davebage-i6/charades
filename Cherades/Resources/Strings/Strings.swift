//
//  Strings.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import Foundation
import SwiftUI

typealias IterableCheradeString = CheradeString & CaseIterable

public enum Strings {
    public enum SelectionText: String, IterableCheradeString {
        case needAtLeastTwo = "selectiontext.needatleasttwo"
        case selectTwo = "selectiontext.selecttwo"
        case selectOneMore = "selectiontext.onemore"
        case youreSet = "selectiontext.youreset"
        case letsgo = "selectiontext.letsgo"
    }
    
    public enum GameInterface: String, IterableCheradeString {
        case teamsTitle = "gameinterface.teamstitle"
        case timeRemaining = "gameinterface.timeremaining"
        case go = "gameinterface.go"
        case stop = "gameinterface.stop"
        case nextTeam = "gameinterface.nextteam"
        case getSuggestion = "gameinterface.getsuggestion"
        case noSuggestions = "gameinterface.nosuggestions"
    }
}

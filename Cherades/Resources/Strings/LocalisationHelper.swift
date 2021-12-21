//
//  LocalisationHelper.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import Foundation

public protocol CheradeString {
    var localized: String { get }
}

public extension CheradeString where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        return NSLocalizedString(rawValue, tableName: "CheradeStrings", bundle: CheradeBundle.shared, value: "**\(self)**", comment: "")
    }
}

//
//  CheradeBundle.swift
//  Cherades
//
//  Created by Dave Bage on 14/12/2021.
//

import Foundation

internal class CheradeBundle { // A tag class that resources can use to identify this bundle
    
    static let shared = Bundle(for: CheradeBundle.self)
}

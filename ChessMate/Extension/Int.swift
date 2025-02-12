//
//  Int.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import Foundation

extension Int {
    var toChessColumn: String {
        guard self >= 0 && self < 8 else { return "?" }
        return String(UnicodeScalar(97 + self)!)
    }
}


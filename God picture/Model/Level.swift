//
//  Level.swift
//  God picture
//
//  Created by Данил Менделев on 23.06.2023.
//

import Foundation

struct LevelSize: Codable {
    let f: Int
    let s: Int
}

enum LevelType {
    case one
    case two
    case three
    case four
    
    func getValue() -> LevelSize {
        switch self {
        case .one:
            return LevelSize(f: 2, s: 3)
        case .two:
            return LevelSize(f: 2, s: 4)
        case .three:
            return LevelSize(f: 4, s: 4)
        case .four:
            return LevelSize(f: 4, s: 6)
        }
    }
}



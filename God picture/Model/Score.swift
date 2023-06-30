//
//  Score.swift
//  God picture
//
//  Created by Данил Менделев on 21.06.2023.
//

import Foundation

struct Score: Codable {
    var id = UUID()
    let level: Int
    let countStar: Int
    let size: LevelSize
}

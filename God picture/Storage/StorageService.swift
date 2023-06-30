//
//  StorageService.swift
//  God picture
//
//  Created by Данил Менделев on 23.06.2023.
//
import UIKit
import Foundation


final class StorageService {
    
    static let shared: StorageService = StorageService()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    
    private init() {
        firstStart()
    }
    
    private func firstStart() {
        let firstStart = defaults.bool(forKey: "firstStart")
        if !firstStart {
            setDefaultData()
        }
    }
    
    private func setDefaultData() {
        defaults.set(true, forKey: "firstStart")
        defaults.set(1, forKey: "currentLevel")
        for number in 1...2 {
            let value = Score(level: number, countStar: 0, size: LevelType.one.getValue())
            if let encoder = try? encoder.encode(value) {
                defaults.set(encoder, forKey: "\(number)")
            }
        }
        for number in 3...6 {
            let value = Score(level: number, countStar: 0, size: LevelType.two.getValue())
            if let encoder = try? encoder.encode(value) {
                defaults.set(encoder, forKey: "\(number)")
            }
        }
        for number in 7...10 {
            let value = Score(level: number, countStar: 0, size: LevelType.three.getValue())
            if let encoder = try? encoder.encode(value) {
                defaults.set(encoder, forKey: "\(number)")
            }
        }
        for number in 11...20 {
            let value = Score(level: number, countStar: 0, size: LevelType.four.getValue())
            if let encoder = try? encoder.encode(value) {
                defaults.set(encoder, forKey: "\(number)")
            }
        }
    }
    
    func saveProgressBy(level: Int, data: Score) {
        let score = getProgressByLevel(level)
        if score.countStar < data.countStar {
            if let encoded = try? encoder.encode(data) {
                defaults.set(encoded, forKey: "\(level)")
            }
        }
    }
    
    func getProgressByLevel(_ level: Int) -> Score {
        var result: Score!
        if let savedData = defaults.object(forKey: "\(level)") as? Data {
            if let loadedData = try? decoder.decode(Score.self, from: savedData) {
                result = loadedData
            }
        }
        return result
    }
    
    func saveCurrentLevel(_ number: Int) {
        defaults.set(number, forKey: "currentLevel")
    }
    
    func getAllProgress() -> [Score] {
        var result: [Score] = []
        
        for number in 1...20 {
            if let savedData = defaults.object(forKey: "\(number)") as? Data {
                if let loadedData = try? decoder.decode(Score.self, from: savedData) {
                    result.append(loadedData)
                }
            }
        }
        
        return result
    }
    
    func getCurrentLevel() -> Int {
        defaults.integer(forKey: "currentLevel")
    }
    
}

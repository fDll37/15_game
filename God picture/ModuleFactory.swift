//
//  ModuleFactory.swift
//  God picture
//
//  Created by Данил Менделев on 17.06.2023.
//
import UIKit
import Foundation

protocol ModuleFactory {
    func getModule(by type: TypeModule) -> UIViewController
}

enum TypeModule {
    case start
    case main
    case levels
}


final class ModuleFactoryImpl: ModuleFactory {
    
    func getModule(by type: TypeModule) -> UIViewController {
        
        switch type {
            
        case .start:
            let game = GameViewController()
            return game
        case .main:
            return ViewController()
        case .levels:
            return LevelViewController()
        }
    }
    
}

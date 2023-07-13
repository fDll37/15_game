//
//  Gradient.swift
//  God picture
//
//  Created by Данил Менделев on 04.07.2023.
//

import UIKit

class Gradient: UIView {
    
    func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.locations = locations
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradientLayer.frame = frame
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

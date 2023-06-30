//
//  Game.swift
//  God picture
//
//  Created by Данил Менделев on 19.06.2023.
//

import UIKit
import Foundation
import AVFoundation

final class Game {
    
    var currentLevel: Int
    var size: LevelSize
    var countStar: Int
    var currentImage: UIImage!
    var matrixImage: [[Block?]] = []
    var correctListId: [UUID?] = []
    var isWin: Bool = false
    
    init() {
        self.currentLevel = StorageService.shared.getCurrentLevel()
        let data = StorageService.shared.getProgressByLevel(currentLevel)
        self.size = data.size
        self.countStar = data.countStar
        getImage()
        createMatrix()
    }
        
    private func getImage() {
        currentImage = UIImage(named: "level_\(currentLevel)")
    }
    
    private func createMatrix() {
        for row in 0..<size.f {
            var matrixLine: [Block] = []
            for col in 0..<size.s {
                let image = getFrame(x: row, y: col)
                let block = Block(image: image)
                matrixLine.append(block)
                correctListId.append(block.id)
            }
            matrixImage.append(matrixLine)
        }
        correctListId[correctListId.count - 1] = nil
        matrixImage[size.f - 1][size.s - 1] = nil
        shuffled()
    }
    
    func nextLevel() {
        if currentLevel < 20 {
            self.currentLevel += 1
            self.size = StorageService.shared.getProgressByLevel(currentLevel).size
            getImage()
            createMatrix()
        }
    }
    
    private func shuffled() {
        for row in 0..<matrixImage.count {
            matrixImage[row] = matrixImage[row].shuffled()
        }
    }
    
    private func getFrame(x: Int, y: Int) -> UIImage {
    
        let w = currentImage.size.width / CGFloat(size.s)
        let h = currentImage.size.height / CGFloat(size.f)
        let xOffset = currentImage.size.width / CGFloat(size.s) * CGFloat(y)
        let yOffset = currentImage.size.height / CGFloat(size.f) * CGFloat(x)

        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: w,
            height: h
        ).integral

        let sourceCGImage = currentImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(to: cropRect)!

        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: currentImage.imageRendererFormat.scale,
            orientation: currentImage.imageOrientation
        )
        
        return croppedImage
    }
    
    private func checkMatrix() {
        let oneLineMatrix = matrixImage.flatMap{$0.map{$0?.id}}
        isWin = oneLineMatrix == correctListId
    }
    
    private func checkNewPosition(index: [Int]) -> Bool {
        matrixImage[index[0]][index[1]] == nil
    }
    
    func changePosition(old oldPosition: IndexPath, to newPosition: IndexPath) {
        let indexOld = {
            if oldPosition[1] >= size.s {
                let f = Int(oldPosition[1] / size.s)
                let s = oldPosition[1] - size.s * f
                return [f, s]
            }
            else {
                return [oldPosition[0], oldPosition[1]]
            }
        }()
        let indexNew = {
            if newPosition[1] >= size.s {
                let f = Int(newPosition[1] / size.s)
                let s = newPosition[1] - size.s * f
                return [f, s]
            }
            else {
                return [newPosition[0], newPosition[1]]
            }
        }()
        guard checkNewPosition(index: indexNew) else {
            print("Next block is not NILL")
            return
        }
        matrixImage[indexNew[0]][indexNew[1]] = matrixImage[indexOld[0]][indexOld[1]]
        matrixImage[indexOld[0]][indexOld[1]] = nil
        
        checkMatrix()
    }
}

//
//  Sound.swift
//  God picture
//
//  Created by Данил Менделев on 19.07.2023.
//

import Foundation
import AVFoundation

final class Sound {
    
    private enum TypeSound: String {
        case badTry = "badTry"
        case clickButton = "clickButton"
        case congratulation = "congratulation"
    }
    
    private enum FileFormatSound: String {
        case wav = ".wav"
        case mp3 = ".mp3"
    }
    
    enum ChooseSound {
        case bad
        case great
        case click
        
        var play: Void {
            switch self {
                
            case .bad:
                Sound.shared.playSound(name: .badTry, format: .mp3)
            case .great:
                Sound.shared.playSound(name: .congratulation, format: .mp3)
            case .click:
                Sound.shared.playSound(name: .clickButton, format: .wav)
            }
            
            return
        }
        
    }
    
    static let shared: Sound = Sound()
    var playerMusic: AVAudioPlayer!
    var playerSound: AVAudioPlayer!
    var isPlay: Bool = false
    
    private init() {}
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "Upbeat Folk", withExtension: ".mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        
            self.playerMusic = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = playerMusic else {return}
            player.numberOfLoops = -1
            player.play()
            
            isPlay.toggle()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopMusic() {
        if isPlay {
            playerMusic.pause()
        } else {
            playerMusic.play()
        }
        isPlay.toggle()
    }
    
    private func playSound(name: TypeSound, format: FileFormatSound) {
        guard let url = Bundle.main.url(forResource: name.rawValue, withExtension: format.rawValue) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        
            self.playerSound = try AVAudioPlayer(contentsOf: url)
            
            guard let player = playerSound else {return}
            if isPlay {
                player.play()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

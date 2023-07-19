//
//  ViewController.swift
//  God picture
//
//  Created by Данил Менделев on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "background")
        return image
    }()
    private lazy var startPersonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "startPerson")
        return image
    }()
    private lazy var nameGameText: UILabel = {
        
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.white,
          NSAttributedString.Key.foregroundColor : UIColor(named: "orange")!,
          NSAttributedString.Key.font: UIFont(name: "DancingScript-Bold", size: 68)!,
          NSAttributedString.Key.strokeWidth : -2.5,
        ]
          as [NSAttributedString.Key : Any]
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Name APP Game", attributes: strokeTextAttributes)
        return label
    }()
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.backgroundColor = UIColor(named: "orange")
        button.setImage(UIImage(systemName: "doc.text.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        return button
    }()
    private lazy var soundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.backgroundColor = UIColor(named: "orange")
        button.setImage(UIImage(named: "soundOn"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.tintColor = .white
        button.addTarget(self, action: #selector(changeSound), for: .touchUpInside)
        return button
    }()
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.backgroundColor = UIColor(named: "orange")
        button.setTitle("PLAY", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Bebas Neue", size: 28)
        button.addTarget(self, action: #selector(startPlay), for: .touchUpInside)
        return button
    }()
    private lazy var levelsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.backgroundColor = UIColor(named: "orange")
        button.setTitle("LEVELS", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Bebas Neue", size: 28)
        button.addTarget(self, action: #selector(chooseLevel), for: .touchUpInside)
        return button
    }()
    
    @objc private func chooseLevel() {
        Sound.ChooseSound.click.play
        navigationController?.pushViewController(LevelViewController(), animated: true)
    }
    @objc private func changeSound() {
        Sound.ChooseSound.click.play
        soundButton.setImage(UIImage(named: Sound.shared.isPlay ? "soundOff" : "soundOn"), for: .normal)
        Sound.shared.stopMusic()
    }
    @objc private func startPlay() {
        Sound.ChooseSound.click.play
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
    @objc private func showInfo() {
        Sound.ChooseSound.click.play
        print("info")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        layout()
    }
    
//    private func toNextScreen(_ type: TypeModule) {
//        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {return}
//        let screen = factory.getModule(by: type)
//        sceneDelegate.window?.rootViewController = screen
//        sceneDelegate.window?.makeKeyAndVisible()
//    }
    
    private func layout() {
        [backgroundImage, startPersonImage, soundButton, playButton, levelsButton, nameGameText, infoButton].forEach{view.addSubview($0)}
        
        let thirdPartScreen = UIScreen.main.bounds.width / 2.8
        let quertPartScreen = UIScreen.main.bounds.width / 4.5
        let twelvePartScreen = UIScreen.main.bounds.height / 8
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            startPersonImage.topAnchor.constraint(equalTo: view.topAnchor),
            startPersonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startPersonImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startPersonImage.widthAnchor.constraint(equalToConstant: thirdPartScreen),
            
            infoButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            infoButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20),
            infoButton.heightAnchor.constraint(equalToConstant: 44),
            infoButton.widthAnchor.constraint(equalToConstant: 44),
            
            soundButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            soundButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20),
            soundButton.heightAnchor.constraint(equalToConstant: 44),
            soundButton.widthAnchor.constraint(equalToConstant: 44),
            
            playButton.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: quertPartScreen),
            playButton.heightAnchor.constraint(equalToConstant: twelvePartScreen),
            
            levelsButton.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            levelsButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 12),
            levelsButton.widthAnchor.constraint(equalToConstant: quertPartScreen),
            levelsButton.heightAnchor.constraint(equalToConstant: twelvePartScreen),
            
            nameGameText.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            nameGameText.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 40),
            nameGameText.widthAnchor.constraint(equalToConstant: thirdPartScreen)
        ])
    }
}


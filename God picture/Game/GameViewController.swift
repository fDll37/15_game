//
//  GameViewController.swift
//  God picture
//
//  Created by Данил Менделев on 19.06.2023.
//

import UIKit


class GameViewController: UIViewController {

    var game = Game()
    var timer = Timer()
    var timeStop = 119
    
    // VIEW
    private lazy var collectionViewImage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
        return view
    }()
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "background")
        return image
    }()
    private lazy var timerLabel: UILabel = {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"timer")
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 18)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: "   01:59")
        completeText.append(textAfterIcon)
        
        
        let label = UILabel()
        label.backgroundColor = UIColor(named: "orange")
        label.layer.borderColor = UIColor(named: "gold")?.cgColor
        label.layer.borderWidth = 3
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .white
        label.font = UIFont(name: "Bebas Neue", size: 28)
        label.textAlignment = .center
        label.attributedText = completeText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var imageWinView: UIImageView = {
        let view = UIImageView()
        view.image = game.currentImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor(named: "gold")?.cgColor
        label.backgroundColor = UIColor(named: "orange")
        label.clipsToBounds = true
        label.textColor = .white
        label.font = UIFont(name: "Bebas Neue", size: 28)
        label.text = "LEVEL \(game.currentLevel)"
        label.textAlignment = .center
        return label
    }()
    private lazy var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.765
        return view
    }()
    private lazy var buttonNext: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.addTarget(self, action: #selector(nextLevel), for: .touchUpInside)
        return button
    }()
    private lazy var buttonAgain: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "goforward"), for: .normal)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.addTarget(self, action: #selector(againLevel), for: .touchUpInside)
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setGesture()
        setTimer()
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    private func setGesture() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftSwipeGesture.direction = .left
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        upSwipeGesture.direction = .up
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        downSwipeGesture.direction = .down
        let longTapPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLogPress))
        collectionViewImage.addGestureRecognizer(leftSwipeGesture)
        collectionViewImage.addGestureRecognizer(rightSwipeGesture)
        collectionViewImage.addGestureRecognizer(upSwipeGesture)
        collectionViewImage.addGestureRecognizer(downSwipeGesture)
        collectionViewImage.addGestureRecognizer(longTapPress)
        collectionViewImage.isUserInteractionEnabled = true
    }
    
    @objc private func tapBack() {
        Sound.ChooseSound.click.play
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextLevel() {
        Sound.ChooseSound.click.play
        StorageService.shared.saveCurrentLevel(game.currentLevel + 1)
        navigationController?.pushViewController(GameViewController(), animated: true)
        navigationController?.viewControllers.remove(at: (navigationController!.viewControllers.count) - 2)
    }
    
    @objc private func againLevel() {
        Sound.ChooseSound.click.play
        navigationController?.pushViewController(GameViewController(), animated: true)
        navigationController?.viewControllers.remove(at: (navigationController!.viewControllers.count) - 2)
    }

    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        let gestureLocation = sender.location(in: collectionViewImage)
        guard let targetIndexPath = collectionViewImage.indexPathForItem(at: gestureLocation) else {return}
        var secondElement = targetIndexPath
        switch sender.direction {
        case .up:
            secondElement.row -= game.size.s
            guard secondElement.row >= 0 else {return}
        case .down:
            secondElement.row += game.size.s
            guard secondElement.row <= game.size.s * game.size.f else {return}
        case .right:
            secondElement.row += 1
            guard secondElement.row <= game.size.s * game.size.f else {return}
        case .left:
            secondElement.row -= 1
            guard secondElement.row >= 0 else {return}
            
        default:
            return
        }
        game.changePosition(old: targetIndexPath, to: secondElement)
        collectionViewImage.reloadItems(at: [targetIndexPath, secondElement])
        if game.isWin {
            countStarsForLevel()
            gameWin()
        }
    }
    
    @objc private func handleLogPress(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: collectionViewImage)
        
        switch sender.state {
        case .began:
            guard let targetIndexPath = collectionViewImage.indexPathForItem(at: location) else {return}
            collectionViewImage.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionViewImage.updateInteractiveMovementTargetPosition(location)
//            break
        case .ended:
            collectionViewImage.endInteractiveMovement()
        default:
            collectionViewImage.cancelInteractiveMovement()
        }
    }
    
    @objc private func timerAction() {
        timeStop -= 1
        if timeStop == 0 {
            timer.invalidate()
            gameLose()
        } else {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named:"timer")
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 18)
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            let completeText = NSMutableAttributedString(string: "")
            completeText.append(attachmentString)
            let textAfterIcon = NSAttributedString(string: "   \(getTimeFromInt())")
            completeText.append(textAfterIcon)
            
            timerLabel.attributedText = completeText
        }
    }
    
    private func countStarsForLevel() {
        var star: Int!
        if timeStop > 90 {
            star = 3
        } else if timeStop > 45 {
            star = 2
        } else {
            star = 1
        }
        StorageService.shared.saveProgressBy(level: game.currentLevel, data: Score(level: game.currentLevel, countStar: star, size: game.size))
    }
    
    private func getTimeFromInt() -> String {
        var result = ""
        if timeStop / 60 >= 1 {
            result = "01:\(timeStop - 60)"
        }
        else {
            result = "00:\(timeStop)"
        }
        return result
    }
    
    private func gameWin() {
        Sound.ChooseSound.great.play
        let score = ScoreView(frame: .zero, scoreData: StorageService.shared.getProgressByLevel(game.currentLevel))
        score.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageWinView)
        view.addSubview(blackView)
        view.addSubview(score)
        view.addSubview(buttonNext)
        view.addSubview(buttonAgain)
        
        // TODO: Animation
        collectionViewImage.alpha = 0
        
        NSLayoutConstraint.activate([
            imageWinView.topAnchor.constraint(equalTo: collectionViewImage.topAnchor),
            imageWinView.leadingAnchor.constraint(equalTo: collectionViewImage.leadingAnchor),
            imageWinView.trailingAnchor.constraint(equalTo: collectionViewImage.trailingAnchor),
            imageWinView.bottomAnchor.constraint(equalTo: collectionViewImage.bottomAnchor),
            
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            score.centerXAnchor.constraint(equalTo: blackView.centerXAnchor),
            score.centerYAnchor.constraint(equalTo: blackView.centerYAnchor),
            score.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 8),
            score.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4.5),
            
            buttonAgain.topAnchor.constraint(equalTo: score.bottomAnchor, constant: 10),
            buttonAgain.leadingAnchor.constraint(equalTo: score.leadingAnchor, constant: 10),
            buttonAgain.trailingAnchor.constraint(equalTo: buttonNext.leadingAnchor, constant: -10),
            buttonAgain.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 8),
            buttonAgain.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 13.5),
            
            buttonNext.topAnchor.constraint(equalTo: buttonAgain.topAnchor),
            buttonNext.trailingAnchor.constraint(equalTo: score.trailingAnchor, constant: -10),
            buttonNext.bottomAnchor.constraint(equalTo: buttonAgain.bottomAnchor),
            buttonNext.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 8),
            buttonNext.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 13.5),
        ])
        
        timer.invalidate()
    }
    
    private func gameLose() {
        timer.invalidate()
        Sound.ChooseSound.bad.play
        let lose = LoseView {
            self.navigationController?.popViewController(animated: true)
        }
        lose.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        view.addSubview(lose)
        
        NSLayoutConstraint.activate([
            
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lose.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lose.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lose.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            lose.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
        ])

    }
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(backButton)
        view.addSubview(collectionViewImage)
        view.addSubview(timerLabel)
        view.addSubview(levelLabel)
        
        let constant: CGFloat = 30
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionViewImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: constant),
            collectionViewImage.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 58),
            collectionViewImage.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -58),
            collectionViewImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -constant),
            
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -7),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4.3),
            timerLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 9),

            levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 7),
            levelLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 9),
            levelLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 5)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        game.size.f * game.size.s
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = { 
            if indexPath[1] >= game.size.s {
                let f = Int(indexPath[1] / game.size.s)
                let s = indexPath[1] - game.size.s * f
                return [f, s]
            }
            else {
                return [indexPath[0], indexPath[1]]
            }
        }()
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        
        cell.setupCollectionCell(game.matrixImage[index[0]][index[1]]?.image)
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension GameViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 2}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * CGFloat(game.size.s + 1)) / CGFloat(game.size.s)
        let height = (collectionView.bounds.height - sideInset * CGFloat(game.size.f + 1)) / CGFloat(game.size.f)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}


// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        game.changePosition(old: sourceIndexPath, to: destinationIndexPath)
        collectionViewImage.reloadData()
    }
}

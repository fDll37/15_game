//
//  LevelViewController.swift
//  God picture
//
//  Created by Данил Менделев on 16.06.2023.
//

import UIKit

class LevelViewController: UIViewController {
    
    private var currentLevel = StorageService.shared.getCurrentLevel()
    private var allData = StorageService.shared.getAllProgress()
    
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
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(named: "gold")?.cgColor
        label.backgroundColor = UIColor(named: "orange")
        label.clipsToBounds = true
        label.textColor = .white
        label.font = UIFont(name: "Bebas Neue", size: 28)
        label.text = "LEVELS"
        label.textAlignment = .center
        return label
    }()
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "background")
        return image
    }()
    private lazy var collectionViewScore: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        view.delegate = self
        view.dataSource = self
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LevelCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: LevelCollectionViewCell.self))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setupGradient()
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupGradient() {
        let backView = Gradient()
        backView.addGradient([UIColor(named: "top")!, UIColor(named: "down")!], locations: [0.0, 1.0], frame: view.frame)
        collectionViewScore.backgroundView = backView
    }
    
    private func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(backButton)
        view.addSubview(levelLabel)
        view.addSubview(collectionViewScore)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 45),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            
            levelLabel.bottomAnchor.constraint(equalTo: collectionViewScore.topAnchor, constant: 5),
            levelLabel.centerXAnchor.constraint(equalTo: collectionViewScore.centerXAnchor),
            levelLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 15),
            levelLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 5),
            
            collectionViewScore.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 65),
            collectionViewScore.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            collectionViewScore.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 8),
            collectionViewScore.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.7),
            
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension LevelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LevelCollectionViewCell.self), for: indexPath) as? LevelCollectionViewCell else {return UICollectionViewCell()}
        cell.setupCell(allData[indexPath.row])
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension LevelViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 32}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * CGFloat(6)) / CGFloat(5)
        let height = width * 5 / 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 29, left: 48, bottom: sideInset, right: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        StorageService.shared.saveCurrentLevel(indexPath.row + 1)
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
}


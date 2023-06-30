//
//  LevelCollectionViewCell.swift
//  God picture
//
//  Created by Данил Менделев on 21.06.2023.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor(named: "gold")?.cgColor
        label.backgroundColor = UIColor(named: "orange")
        label.layer.cornerRadius = 15
        label.font = UIFont(name: "Bebas Neue", size: 28)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fStar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sStar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tStar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ data: Score) {
        levelLabel.text = String(data.level)
        if data.countStar == 3 {
            [fStar, sStar, tStar].forEach{$0.image = UIImage(named: "star_fill")}
        } else if data.countStar == 2 {
            [fStar, sStar].forEach{$0.image = UIImage(named: "star_fill")}
        } else if data.countStar == 1 {
            [fStar].forEach{$0.image = UIImage(named: "star_fill")}
        }
    }
    
    private func layout() {
        addSubview(fStar)
        addSubview(sStar)
        addSubview(tStar)
        addSubview(levelLabel)
        
        let constant: CGFloat = self.bounds.width / 3
        
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            levelLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 2/3),
            
            fStar.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 5),
            fStar.leadingAnchor.constraint(equalTo: levelLabel.leadingAnchor),
            fStar.trailingAnchor.constraint(equalTo: sStar.leadingAnchor),
            fStar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            fStar.widthAnchor.constraint(equalToConstant: constant),
            
            sStar.topAnchor.constraint(equalTo: fStar.topAnchor),
            sStar.bottomAnchor.constraint(equalTo: fStar.bottomAnchor),
            sStar.widthAnchor.constraint(equalToConstant: constant),
            
            tStar.topAnchor.constraint(equalTo: fStar.topAnchor),
            tStar.bottomAnchor.constraint(equalTo: fStar.bottomAnchor),
            tStar.leadingAnchor.constraint(equalTo: sStar.trailingAnchor),
            tStar.trailingAnchor.constraint(equalTo: levelLabel.trailingAnchor),
            tStar.widthAnchor.constraint(equalToConstant: constant)
            
        ])
        
    }
}

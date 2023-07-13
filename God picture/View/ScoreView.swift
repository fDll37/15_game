//
//  ScoreView.swift
//  God picture
//
//  Created by Данил Менделев on 21.06.2023.
//

import UIKit

class ScoreView: UIView {

    var dataScore: Score
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "\(dataScore.level)"
        label.textColor = .white
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor(named: "gold")?.cgColor
        label.backgroundColor = UIColor(named: "orange")
        label.layer.cornerRadius = 10
        label.font = UIFont(name: "Bebas Neue", size: 28)
        label.textAlignment = .center
        label.clipsToBounds = true
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
    
    init(frame: CGRect, scoreData: Score) {
        dataScore = scoreData
        super.init(frame: frame)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        if dataScore.countStar == 3 {
            [fStar, sStar, tStar].forEach{$0.image = UIImage(named: "star_fill")}
        } else if dataScore.countStar == 2 {
            [fStar, sStar].forEach{$0.image = UIImage(named: "star_fill")}
        } else if dataScore.countStar == 1 {
            [fStar].forEach{$0.image = UIImage(named: "star_fill")}
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            levelLabel.heightAnchor.constraint(equalToConstant: bounds.height * 2/3),
            
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

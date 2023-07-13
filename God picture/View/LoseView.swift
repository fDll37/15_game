//
//  LoseView.swift
//  God picture
//
//  Created by Данил Менделев on 23.06.2023.
//

import UIKit

class LoseView: UIView {
    
    private var action: ()-> Void
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Bebas Neue", size: 30)
        label.textColor = UIColor(named: "orange")
        label.text = "YOU LOSE"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "gold")?.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector(loseTap), for: .touchUpInside)
        return button
    }()
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @objc private func loseTap() {
        action()
    }
    
    private func layout() {
        [whiteView,  textLabel, crossButton].forEach{addSubview($0)}
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
       
            crossButton.topAnchor.constraint(equalTo: topAnchor),
            crossButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            crossButton.widthAnchor.constraint(equalToConstant: 15),
            crossButton.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}

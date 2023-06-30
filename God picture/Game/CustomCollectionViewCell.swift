//
//  CustomCollectionViewCell.swift
//  God picture
//
//  Created by Данил Менделев on 19.06.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private let imageCollectionCell: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCollectionCell.image = nil
    }
    
    func setupCollectionCell(_ image: UIImage?){
        imageCollectionCell.image = image
    }
    
    private func layout(){
        contentView.addSubview(imageCollectionCell)
        NSLayoutConstraint.activate([
            imageCollectionCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

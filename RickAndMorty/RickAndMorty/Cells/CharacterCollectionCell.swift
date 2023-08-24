//
//  CharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    
    var data: CharacterModel? {
        didSet {
            guard let data = data else { return }
            characterImageView.image =  UIImage(named: data.image ?? "")
            characterNameLabel.text = data.name
        }
    }
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .center
        nameText.textColor = .white
        nameText.numberOfLines = 1
        nameText.font = UIFont.boldSystemFont(ofSize: 19.0)
        return nameText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = 16
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -16).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

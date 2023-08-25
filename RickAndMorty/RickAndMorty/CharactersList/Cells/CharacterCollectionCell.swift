//
//  CharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var defaultSidePadding: CGFloat { 10 }
    static var defaultBottomSidePadding: CGFloat { 10 }
    
    static var characterNameLabelHeight: CGFloat { 22 }
    static var characterImageCornerRadius: CGFloat { 10 }
    static var characterNameLinesNumber: Int { 1 }
    static var characterNameTextColor: UIColor { .white }
    static var characterNameTextFont: UIFont { .boldSystemFont(ofSize: 19) }
    
    static var cellCornerRadius: CGFloat { 16 }
}

class CharacterCollectionCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            characterNameLabel.text = data.name
        }
    }
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.characterImageCornerRadius
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .center
        nameText.textColor = Constants.characterNameTextColor
        nameText.numberOfLines = Constants.characterNameLinesNumber
        nameText.font = Constants.characterNameTextFont
        return nameText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                   constant: -Constants.defaultBottomSidePadding).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.defaultSidePadding).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.defaultSidePadding).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: Constants.characterNameLabelHeight).isActive = true
        
        characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultSidePadding).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.defaultSidePadding).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.defaultSidePadding).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor,
                                                   constant: -Constants.defaultBottomSidePadding).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

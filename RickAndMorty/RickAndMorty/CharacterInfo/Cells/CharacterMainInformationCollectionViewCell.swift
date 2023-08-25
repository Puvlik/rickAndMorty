//
//  CharacterMainInformationCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var labelLinesNumber: Int { 0 }
    
    static var characterImageViewCornerRadius: CGFloat { 25 }
    static var characterImageViewSideSize: CGFloat { 160 }
    
    static var characterAliveStatus: String { "Alive" }
    static var characterDeadStatus: String { "Dead" }

    static var characterAliveStatusTextColor: UIColor { .green }
    static var characterDeadStatusTextColor: UIColor { .red }
    static var characterUnknownTextColor: UIColor { .orange }
    static var characterNameTextColor: UIColor { .white }
    
    static var characterNameLabelFontStyle: UIFont { .boldSystemFont(ofSize: 22) }
    static var characterLifeStatusFontStyle: UIFont { .boldSystemFont(ofSize: 16) }
}

class CharacterMainInformationCollectionViewCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            characterNameLabel.text = data.name
            characterLifeStatusLabel.text = data.aliveStatus
            
            switch data.aliveStatus {
            case Constants.characterAliveStatus:
                characterLifeStatusLabel.textColor = Constants.characterAliveStatusTextColor
            case Constants.characterDeadStatus:
                characterLifeStatusLabel.textColor = Constants.characterDeadStatusTextColor
            default:
                characterLifeStatusLabel.textColor = Constants.characterUnknownTextColor
            }
        }
    }
    
    private lazy var informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()

    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.characterImageViewCornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var characterNameLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .center
        nameText.textColor = Constants.characterNameTextColor
        nameText.numberOfLines = Constants.labelLinesNumber
        nameText.font = Constants.characterNameLabelFontStyle
        return nameText
    }()
    
    private lazy var characterLifeStatusLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .center
        nameText.numberOfLines = Constants.labelLinesNumber
        nameText.font = Constants.characterLifeStatusFontStyle
        return nameText
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        informationStackView.addArrangedSubview(characterNameLabel)
        informationStackView.addArrangedSubview(characterLifeStatusLabel)
        addSubview(informationStackView)
        addSubview(characterImageView)

        characterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: Constants.characterImageViewSideSize).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: Constants.characterImageViewSideSize).isActive = true
        
        informationStackView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor).isActive = true
        informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        informationStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        informationStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

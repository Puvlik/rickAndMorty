//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var emptyString: String { "" }
    static var characterNoneTypeString: String { "None" }
    static var speciesPlaceholderString: String { "Species" }
    static var typePlaceholderString: String { "Type" }
    static var genderPlaceholderString: String { "Gender" }

    static var cellCornerRadius: CGFloat { 16 }
    static var verticalPadding: CGFloat { 12 }
    static var horizontalPadding: CGFloat { 16 }
}

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            let characterTypeString = data.type == Constants.emptyString ? Constants.characterNoneTypeString : data.type
            characterInfoPlaceholdersStackView.setupView(
                alignment: .left,
                topLabelText: Constants.speciesPlaceholderString,
                middleLabelText: Constants.typePlaceholderString,
                bottomLabelText: Constants.genderPlaceholderString
            )
            
            characterInformationLabelsStackView.setupView(
                alignment: .right,
                topLabelText: data.creatureType,
                middleLabelText: characterTypeString,
                bottomLabelText: data.gender
            )
        }
    }
    
    private lazy var characterInfoPlaceholdersStackView: ThreeLabelsStackView = {
        let view = ThreeLabelsStackView()
        view.alignment = .leading
        return view
    }()
    
    private lazy var characterInformationLabelsStackView: ThreeLabelsStackView = {
        let view = ThreeLabelsStackView()
        view.alignment = .trailing
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius

        addSubview(characterInfoPlaceholdersStackView)
        addSubview(characterInformationLabelsStackView)

        characterInfoPlaceholdersStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.verticalPadding).isActive = true
        characterInfoPlaceholdersStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: Constants.horizontalPadding).isActive = true
        characterInfoPlaceholdersStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.verticalPadding).isActive = true
        
        characterInformationLabelsStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.verticalPadding).isActive = true
        characterInformationLabelsStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.horizontalPadding).isActive = true
        characterInformationLabelsStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.verticalPadding).isActive = true
        characterInformationLabelsStackView.leadingAnchor.constraint(equalTo: characterInfoPlaceholdersStackView.trailingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var typeLabelLinesNumber: Int { 2 }

    static var emptyString: String { "" }
    static var characterNoneTypeString: String { "None" }
    static var speciesPlaceholderString: String { "Species" }
    static var typePlaceholderString: String { "Type" }
    static var genderPlaceholderString: String { "Gender" }

    static var stackItemsSpacing: CGFloat { 5 }
    static var cellCornerRadius: CGFloat { 16 }
    static var verticalPadding: CGFloat { 12 }
    static var horizontalPadding: CGFloat { 16 }

    static var placeholderDefaultTextColor: UIColor { .gray }
    static var infoDefaultTextColor: UIColor { .white }
    static var labelsDefaultFontStyle: UIFont { .boldSystemFont(ofSize: 16) }
}

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            speciesLabel.text = data.creatureType
            typeLabel.text = data.type == Constants.emptyString ? Constants.characterNoneTypeString : data.type
            genderLabel.text = data.gender
        }
    }
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.spacing = Constants.stackItemsSpacing
        return stack
    }()
    
    private lazy var speciesPlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = Constants.speciesPlaceholderString
        text.textAlignment = .left
        text.textColor = Constants.placeholderDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    private lazy var typePlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = Constants.typePlaceholderString
        text.textAlignment = .left
        text.textColor = Constants.placeholderDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    private lazy var genderPlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = Constants.genderPlaceholderString
        text.textAlignment = .left
        text.textColor = Constants.placeholderDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    private lazy var characterInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .trailing
        stack.spacing = Constants.stackItemsSpacing
        return stack
    }()
    
    private lazy var speciesLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .right
        text.textColor = Constants.infoDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    private lazy var typeLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .right
        text.numberOfLines = Constants.typeLabelLinesNumber
        text.textColor = Constants.infoDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    private lazy var genderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .right
        text.textColor = Constants.infoDefaultTextColor
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius
        
        labelsStackView.addArrangedSubview(speciesPlaceholderLabel)
        labelsStackView.addArrangedSubview(typePlaceholderLabel)
        labelsStackView.addArrangedSubview(genderPlaceholderLabel)
        addSubview(labelsStackView)
        
        characterInfoStackView.addArrangedSubview(speciesLabel)
        characterInfoStackView.addArrangedSubview(typeLabel)
        characterInfoStackView.addArrangedSubview(genderLabel)
        addSubview(characterInfoStackView)
        
        labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding).isActive = true
        labelsStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: Constants.horizontalPadding).isActive = true
        labelsStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.verticalPadding).isActive = true
        
        characterInfoStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.verticalPadding).isActive = true
        characterInfoStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.horizontalPadding).isActive = true
        characterInfoStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.verticalPadding).isActive = true
        characterInfoStackView.leadingAnchor.constraint(equalTo: labelsStackView.trailingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

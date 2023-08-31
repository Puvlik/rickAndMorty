//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import Foundation
import UIKit

// MARK: - Constants
private enum Constants {
    static var emptyString: String { "" }
    static var characterNoneTypeString: String { "None" }
    static var speciesPlaceholderString: String { "Species" }
    static var typePlaceholderString: String { "Type" }
    static var genderPlaceholderString: String { "Gender" }

    static var cellCornerRadius: CGFloat { 16 }
    static var defaultPadding12: CGFloat { 12 }
    static var defaultPadding16: CGFloat { 16 }
    static var characterPlaceholderViewWidth: CGFloat { 60 }
}

// MARK: - CharacterInfoCollectionViewCell
/// Cell for presenting character personal information
final class CharacterInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties
    var data: CharacterFullInfoModel? {
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

    // MARK: - Private properties
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

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupSubviews() {
        addSubview(characterInfoPlaceholdersStackView)
        addSubview(characterInformationLabelsStackView)

        characterInfoPlaceholdersStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.defaultPadding12).isActive = true
        characterInfoPlaceholdersStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: Constants.defaultPadding16).isActive = true
        characterInfoPlaceholdersStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.defaultPadding12).isActive = true
        characterInfoPlaceholdersStackView.widthAnchor.constraint(
            equalToConstant: Constants.characterPlaceholderViewWidth).isActive = true

        characterInformationLabelsStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.defaultPadding12).isActive = true
        characterInformationLabelsStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.defaultPadding16).isActive = true
        characterInformationLabelsStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.defaultPadding12).isActive = true
        characterInformationLabelsStackView.leadingAnchor.constraint(
            equalTo: characterInfoPlaceholdersStackView.trailingAnchor).isActive = true
    }
}

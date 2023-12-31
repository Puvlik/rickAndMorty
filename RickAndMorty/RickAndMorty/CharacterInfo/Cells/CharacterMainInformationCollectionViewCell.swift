//
//  CharacterMainInformationCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import Foundation
import Kingfisher
import UIKit

// MARK: - Constants
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
    static var characterLifeStatusFontStyle: UIFont { .systemFont(ofSize: 16, weight: .medium) }
}

// MARK: - CharacterMainInformationCollectionViewCell
/// Cell for presenting character main detailed information
final class CharacterMainInformationCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties
    var data: CharacterFullInfoModel? {
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

    // MARK: - Private properties
    private lazy var informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.characterImageViewCornerRadius
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Constants.characterNameTextColor
        label.numberOfLines = Constants.labelLinesNumber
        label.font = Constants.characterNameLabelFontStyle
        return label
    }()

    private lazy var characterLifeStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = Constants.labelLinesNumber
        label.font = Constants.characterLifeStatusFontStyle
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func setupCharacterImageViewWithImage(_ image: KF.ImageResource) {
        characterImageView.kf.setImage(with: image)
    }

    // MARK: - Private methods
    private func setupSubviews() {
        informationStackView.addArrangedSubview(characterNameLabel)
        informationStackView.addArrangedSubview(characterLifeStatusLabel)
        addSubview(informationStackView)
        addSubview(characterImageView)

        characterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        characterImageView.heightAnchor.constraint(
            equalToConstant: Constants.characterImageViewSideSize).isActive = true
        characterImageView.widthAnchor.constraint(
            equalToConstant: Constants.characterImageViewSideSize).isActive = true

        informationStackView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor).isActive = true
        informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        informationStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        informationStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
}

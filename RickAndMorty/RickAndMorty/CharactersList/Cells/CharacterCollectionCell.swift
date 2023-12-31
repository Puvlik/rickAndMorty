//
//  CharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import Kingfisher
import UIKit

// MARK: - Constants
private enum Constants {
    static var cellCornerRadius: CGFloat { 16 }
    static var characterImageCornerRadius: CGFloat { 10 }
    static var defaultSidePadding10: CGFloat { 10 }
    static var characterNameLabelHeight: CGFloat { 22 }

    static var characterNameNumberOfLines: Int { 1 }

    static var characterNameTextColor: UIColor { .white }

    static var characterNameTextFont: UIFont { .boldSystemFont(ofSize: 19) }
}

// MARK: - CharacterCollectionCell
final class CharacterCollectionCell: UICollectionViewCell {

    // MARK: - Public properties
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            characterNameLabel.text = data.name
        }
    }

    // MARK: - Private properties
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.characterImageCornerRadius
        return imageView
    }()

    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Constants.characterNameTextColor
        label.numberOfLines = Constants.characterNameNumberOfLines
        label.font = Constants.characterNameTextFont
        return label
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius
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
        addSubview(characterImageView)
        addSubview(characterNameLabel)

        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                   constant: -Constants.defaultSidePadding10).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.defaultSidePadding10).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.defaultSidePadding10).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: Constants.characterNameLabelHeight).isActive = true

        characterImageView.topAnchor.constraint(equalTo: topAnchor,
                                                constant: Constants.defaultSidePadding10).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.defaultSidePadding10).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.defaultSidePadding10).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor,
                                                   constant: -Constants.defaultSidePadding10).isActive = true
    }
}

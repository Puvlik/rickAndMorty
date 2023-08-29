//
//  CharacterOriginCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 25.08.23.
//

import Foundation
import UIKit

private enum Constants {
    static var cellCornerRadius: CGFloat { 16 }
    static var backgroundViewCornerRadius: CGFloat { 10 }
    static var defaultPadding8: CGFloat { 8 }
    static var defaultPadding16: CGFloat { 16 }
    static var planetImageBackgroundViewWidth: CGFloat { 64 }
    static var defaultSizeValue20: CGFloat { 20 }
    static var defaultSizeValue22: CGFloat { 22 }

    static var planetImageName: String { "planet" }

    static var placeholderDefaultTextColor: UIColor { UIColor().hexStringToUIColor(hex: "#191C2A") }
    static var planetNameTextColor: UIColor { .white }
    static var planetTypeTextColor: UIColor { .green }

    static var planetNameLabelFontStyle: UIFont { .boldSystemFont(ofSize: 17) }
    static var planetTypeFontStyle: UIFont { .systemFont(ofSize: 13, weight: .medium) }
}

class CharacterOriginCollectionCell: UICollectionViewCell {
    var data: Location? {
        didSet {
            guard let data = data else { return }
            planetNameLabel.text = data.name
            planetTypeLabel.text = data.type
        }
    }

    private lazy var planetImageBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.placeholderDefaultTextColor
        view.layer.cornerRadius = Constants.backgroundViewCornerRadius
        return view
    }()

    private lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.planetImageName)
        return imageView
    }()

    private lazy var planetNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Constants.planetNameTextColor
        label.font = Constants.planetNameLabelFontStyle
        return label
    }()

    private lazy var planetTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Constants.planetTypeTextColor
        label.font = Constants.planetTypeFontStyle
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius

        addSubview(planetImageBackgroundView)
        addSubview(planetNameLabel)
        addSubview(planetTypeLabel)
        planetImageBackgroundView.addSubview(planetImageView)

        planetImageBackgroundView.topAnchor.constraint(equalTo: topAnchor,
                                                       constant: Constants.defaultPadding8).isActive = true
        planetImageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                           constant: Constants.defaultPadding8).isActive = true
        planetImageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                          constant: -Constants.defaultPadding8).isActive = true
        planetImageBackgroundView.widthAnchor.constraint(
            equalToConstant: Constants.planetImageBackgroundViewWidth).isActive = true

        planetImageView.centerXAnchor.constraint(equalTo: planetImageBackgroundView.centerXAnchor).isActive = true
        planetImageView.centerYAnchor.constraint(equalTo: planetImageBackgroundView.centerYAnchor).isActive = true
        planetImageView.widthAnchor.constraint(equalToConstant: Constants.defaultSizeValue22).isActive = true
        planetImageView.heightAnchor.constraint(equalToConstant: Constants.defaultSizeValue20).isActive = true

        planetNameLabel.topAnchor.constraint(equalTo: topAnchor,
                                             constant: Constants.defaultPadding16).isActive = true
        planetNameLabel.leadingAnchor.constraint(equalTo: planetImageBackgroundView.trailingAnchor,
                                                 constant: Constants.defaultPadding16).isActive = true
        planetNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -Constants.defaultPadding8).isActive = true
        planetNameLabel.heightAnchor.constraint(equalToConstant: Constants.defaultSizeValue22).isActive = true

        planetTypeLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor,
                                             constant: Constants.defaultPadding8).isActive = true
        planetTypeLabel.leadingAnchor.constraint(equalTo: planetImageBackgroundView.trailingAnchor,
                                                 constant: Constants.defaultPadding16).isActive = true
        planetTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -Constants.defaultPadding8).isActive = true
        planetTypeLabel.heightAnchor.constraint(equalToConstant: Constants.defaultSizeValue22).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

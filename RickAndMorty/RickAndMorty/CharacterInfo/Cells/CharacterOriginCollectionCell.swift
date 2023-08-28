//
//  CharacterOriginCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 25.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var cellCornerRadius: CGFloat { 16 }
    static var backgroundViewCornerRadius: CGFloat { 10 }
    static var planetImageBackgroundViewSidePadding: CGFloat { 8 }
    static var planetImageBackgroundViewWidth: CGFloat { 64 }
    static var planetImageViewWidth: CGFloat { 22 }
    static var planetImageViewHeight: CGFloat { 20 }

    static var planetImageName: String { "planet" }
    static var planetTypePlaceholderText: String { "Planet" }
    
    static var planetNameLabelTopPadding: CGFloat { 16 }
    static var planetNameLabelLeftPadding: CGFloat { 16 }
    static var planetNameLabelRightPadding: CGFloat { 8 }
    static var planetNameLabelHeight: CGFloat { 22 }

    static var placeholderDefaultTextColor: UIColor { UIColor().hexStringToUIColor(hex: "#191C2A") }
    static var planetNameTextColor: UIColor { .white }
    static var planetTypeTextColor: UIColor { .green }
    
    static var planetNameLabelFontStyle: UIFont { .boldSystemFont(ofSize: 17) }
    static var planetTypeFontStyle: UIFont { .systemFont(ofSize: 13, weight: .medium) }
}

class CharacterOriginCollectionCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            planetNameLabel.text = data.origin.name
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
        label.text = Constants.planetTypePlaceholderText
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

        planetImageBackgroundView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.planetImageBackgroundViewSidePadding).isActive = true
        planetImageBackgroundView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: Constants.planetImageBackgroundViewSidePadding).isActive = true
        planetImageBackgroundView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.planetImageBackgroundViewSidePadding).isActive = true
        planetImageBackgroundView.widthAnchor.constraint(
            equalToConstant: Constants.planetImageBackgroundViewWidth).isActive = true
        
        planetImageView.centerXAnchor.constraint(equalTo: planetImageBackgroundView.centerXAnchor).isActive = true
        planetImageView.centerYAnchor.constraint(equalTo: planetImageBackgroundView.centerYAnchor).isActive = true
        planetImageView.widthAnchor.constraint(equalToConstant: Constants.planetImageViewWidth).isActive = true
        planetImageView.heightAnchor.constraint(equalToConstant: Constants.planetImageViewHeight).isActive = true
        
        planetNameLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.planetNameLabelTopPadding).isActive = true
        planetNameLabel.leadingAnchor.constraint(
            equalTo: planetImageBackgroundView.trailingAnchor,
            constant: Constants.planetNameLabelLeftPadding).isActive = true
        planetNameLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.planetNameLabelRightPadding).isActive = true
        planetNameLabel.heightAnchor.constraint(equalToConstant: Constants.planetNameLabelHeight).isActive = true
        
        planetTypeLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: Constants.planetNameLabelRightPadding).isActive = true
        planetTypeLabel.leadingAnchor.constraint(
            equalTo: planetImageBackgroundView.trailingAnchor,
            constant: Constants.planetNameLabelLeftPadding).isActive = true
        planetTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.planetNameLabelRightPadding).isActive = true
        planetTypeLabel.heightAnchor.constraint(equalToConstant: Constants.planetNameLabelHeight).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

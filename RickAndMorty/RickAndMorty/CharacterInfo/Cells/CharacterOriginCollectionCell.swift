//
//  CharacterOriginCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 25.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var placeholderDefaultTextColor: UIColor { UIColor().hexStringToUIColor(hex: "#191C2A") }
    static var cellCornerRadius: CGFloat { 16 }
    static var backgroundViewCornerRadius: CGFloat { 10 }
    static var planetImageName: String { "planet" }
    static var planetNameLinesCount: Int { 0 }
    static var planetNameTextColor: UIColor { .white }
    static var planetNameLabelFontStyle: UIFont { .boldSystemFont(ofSize: 17) }
    static var planetTypeFontStyle: UIFont { .systemFont(ofSize: 13) }
}

class CharacterOriginCollectionCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
            planetNameLabel.text = data.origin.name
        }
    }
    
    private lazy var planetImageBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.placeholderDefaultTextColor
        backgroundView.layer.cornerRadius = Constants.backgroundViewCornerRadius
        return backgroundView
    }()
    
    private lazy var planetImageView: UIImageView = {
        let planet = UIImageView()
        planet.translatesAutoresizingMaskIntoConstraints = false
        planet.image = UIImage(named: Constants.planetImageName)
        return planet
    }()
    
    private lazy var planetNameLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .left
        nameText.textColor = .white
        nameText.textColor = Constants.planetNameTextColor
        nameText.numberOfLines = Constants.planetNameLinesCount
        nameText.font = Constants.planetNameLabelFontStyle
        return nameText
    }()
    
    private lazy var planetTypeLabel: UILabel = {
        let nameText = UILabel()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textAlignment = .left
        nameText.text = "Planet"
        nameText.textColor = .green
        nameText.numberOfLines = Constants.planetNameLinesCount
        nameText.font = Constants.planetTypeFontStyle
        return nameText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius
    
        addSubview(planetImageBackgroundView)
        addSubview(planetNameLabel)
        addSubview(planetTypeLabel)
        planetImageBackgroundView.addSubview(planetImageView)

        planetImageBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        planetImageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        planetImageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        planetImageBackgroundView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        planetImageView.centerXAnchor.constraint(equalTo: planetImageBackgroundView.centerXAnchor).isActive = true
        planetImageView.centerYAnchor.constraint(equalTo: planetImageBackgroundView.centerYAnchor).isActive = true
        planetImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        planetImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        planetNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        planetNameLabel.leadingAnchor.constraint(
            equalTo: planetImageBackgroundView.trailingAnchor,
            constant: 16).isActive = true
        planetNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        planetNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        planetTypeLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: 8).isActive = true
        planetTypeLabel.leadingAnchor.constraint(
            equalTo: planetImageBackgroundView.trailingAnchor,
            constant: 16).isActive = true
        planetTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        planetTypeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

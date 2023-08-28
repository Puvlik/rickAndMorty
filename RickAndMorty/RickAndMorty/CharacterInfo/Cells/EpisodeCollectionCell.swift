//
//  EpisodeCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 27.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var cellCornerRadius: CGFloat { 16 }
    static var viewPadding16: CGFloat { 16 }
    static var episodeTitleLabelHeight: CGFloat { 22 }

    static var episodeTitleTextColor: UIColor { .white }
    static var episodeCreationTextColor: UIColor { .gray }
    static var episodeDescriptionTextColor: UIColor { .green }

    static var episodeTitleFontStyle: UIFont { .boldSystemFont(ofSize: 17) }
    static var episodeDescriptionFontStyle: UIFont { .systemFont(ofSize: 13, weight: .medium) }
}

class EpisodeCollectionCell: UICollectionViewCell {
    private lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Lawnmower Dog"
        label.textColor = Constants.episodeTitleTextColor
        label.font = Constants.episodeTitleFontStyle
        return label
    }()
    
    private lazy var episodeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Episode: 2, Season: 1"
        label.textColor = Constants.episodeDescriptionTextColor
        label.font = Constants.episodeDescriptionFontStyle
        return label
    }()
    
    private lazy var episodeCreationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "December 9, 2013"
        label.textColor = Constants.episodeCreationTextColor
        label.font = Constants.episodeDescriptionFontStyle
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor().cellBackgroundColor
        layer.cornerRadius = Constants.cellCornerRadius
    
        addSubview(episodeTitleLabel)
        addSubview(episodeDescriptionLabel)
        addSubview(episodeCreationDateLabel)
        
        episodeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.viewPadding16).isActive = true
        episodeTitleLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor, constant: Constants.viewPadding16).isActive = true
        episodeTitleLabel.heightAnchor.constraint(equalToConstant: Constants.episodeTitleLabelHeight).isActive = true
        
        episodeDescriptionLabel.topAnchor.constraint(
            equalTo: episodeTitleLabel.bottomAnchor, constant: Constants.viewPadding16).isActive = true
        episodeDescriptionLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor, constant: Constants.viewPadding16).isActive = true
        episodeDescriptionLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor, constant: -Constants.viewPadding16).isActive = true
        
        episodeCreationDateLabel.centerYAnchor.constraint(
            equalTo: episodeDescriptionLabel.centerYAnchor).isActive = true
        episodeCreationDateLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -Constants.viewPadding16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

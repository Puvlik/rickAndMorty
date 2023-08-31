//
//  CollectionSectionTitleView.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 29.08.23.
//

import Foundation
import UIKit

// MARK: - Constants
private enum Constants {
    static var sectionTitleViewHeight: CGFloat { 22 }
    static var sectionTitleViewLeftPadding: CGFloat { 8 }

    static var sectionTitlePlaceholder: String { "Unknown section" }

    static var sectionTitleFontStyle: UIFont { .systemFont(ofSize: 17, weight: .semibold) }

    static var sectionTitleTextColor: UIColor { .white }
}

// MARK: - SectionTitleCollectionViewCell
/// Cell for imitating section header view
final class SectionTitleCollectionViewCell: UICollectionViewCell {

    /// Section titles
    enum SectionTitleTextEnum: String {
        case unknown = "Unknown"
        case info = "Info"
        case origin = "Origin"
        case episodes = "Episodes"
    }

    // MARK: - Public properties
    var title: SectionTitleTextEnum = .unknown {
        didSet {
            sectionTitleLabel.text = title.rawValue
        }
    }

    // MARK: - Private properties
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Constants.sectionTitleFontStyle
        label.textColor = Constants.sectionTitleTextColor
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupSubviews() {
        addSubview(sectionTitleLabel)

        sectionTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Constants.sectionTitleViewLeftPadding).isActive = true
        sectionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sectionTitleLabel.heightAnchor.constraint(equalToConstant: Constants.sectionTitleViewHeight).isActive = true
    }
}

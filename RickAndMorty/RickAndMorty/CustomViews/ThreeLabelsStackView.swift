//
//  ThreeLabelsStackView.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 26.08.23.
//

import Foundation
import UIKit

enum ThreeLabelsAligment {
    case left
    case right
}

private enum Constants {
    static var viewImensSpacing: CGFloat { 5 }
    static var labelsDefaultFontStyle: UIFont { .boldSystemFont(ofSize: 16) }
    static var placeholderDefaultTextColor: UIColor { .gray }
    static var infoDefaultTextColor: UIColor { .white }
}

class ThreeLabelsStackView: UIStackView {
    private var speciesPlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()

    private var typePlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()

    private var genderPlaceholderLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = Constants.labelsDefaultFontStyle
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .equalCentering
        spacing = Constants.viewImensSpacing

        addArrangedSubview(speciesPlaceholderLabel)
        addArrangedSubview(typePlaceholderLabel)
        addArrangedSubview(genderPlaceholderLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(alignment: ThreeLabelsAligment,
                   topLabelText: String,
                   middleLabelText: String,
                   bottomLabelText: String) {
        let labelsTextAlignment: NSTextAlignment = alignment == .left ? .left : .right
        let labelsTextColor: UIColor = alignment ==
            .left ? Constants.placeholderDefaultTextColor : Constants.infoDefaultTextColor
        speciesPlaceholderLabel.text = topLabelText
        speciesPlaceholderLabel.textAlignment = labelsTextAlignment
        speciesPlaceholderLabel.textColor = labelsTextColor

        typePlaceholderLabel.text = middleLabelText
        typePlaceholderLabel.textAlignment = labelsTextAlignment
        typePlaceholderLabel.textColor = labelsTextColor

        genderPlaceholderLabel.text = bottomLabelText
        genderPlaceholderLabel.textAlignment = labelsTextAlignment
        genderPlaceholderLabel.textColor = labelsTextColor
    }
}

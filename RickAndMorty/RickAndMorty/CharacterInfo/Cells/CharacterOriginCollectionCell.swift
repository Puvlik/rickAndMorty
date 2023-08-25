//
//  CharacterOriginCollectionCell.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 25.08.23.
//

import UIKit
import Foundation

class CharacterOriginCollectionCell: UICollectionViewCell {
    var data: CharacterInfoModel? {
        didSet {
            guard let data = data else { return }
        }
    }
}

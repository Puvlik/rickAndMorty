//
//  CharacterLocationModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

struct CharacterLocationModels: Codable {
    let results: [LocationModel]?
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
}

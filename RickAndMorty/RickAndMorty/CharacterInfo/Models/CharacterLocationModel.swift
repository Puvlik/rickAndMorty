//
//  CharacterLocationModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

// MARK: - CharacterLocationModels
/// Model for fetching character place of birth
struct CharacterLocationModels: Codable {
    /// List of character origin
    let results: [LocationModel]?
}

// MARK: - Location
struct Location: Codable {
    /// Origin id
    let id: Int
    /// Place of birth title
    let name: String
    /// Place of birth type
    let type: String
    /// Place of birth dimension
    let dimension: String
}

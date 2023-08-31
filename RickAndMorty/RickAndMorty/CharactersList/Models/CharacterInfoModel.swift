//
//  CharacterInfoModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation

// MARK: - AllCharactersInfoModel
/// Model for all characters request
struct AllCharactersInfoModel: Codable {
    /// List of all characters
    var results: [CharacterInfoModel]?
}

// MARK: - CharacterInfoModel
/// Temporary model for character
struct CharacterInfoModel: Codable {
    /// Character id
    var id: Int
    /// Character name
    var name: String
    /// Character live status (dead / alive)
    var aliveStatus: String
    /// What type character is
    var creatureType: String
    /// idk wtf
    let type: String
    /// Character gender
    var gender: String
    /// Place of character birth
    var origin: LocationModel
    /// Character image
    var image: String
    /// List of episodes URLs, where character appeared
    var episode: [String]

    private enum CodingKeys: String, CodingKey {
        case id, name, type, gender, origin, image, episode
        case aliveStatus = "status"
        case creatureType = "species"
    }
}

// MARK: - CharacterInfoModel
/// Model for character origin field
struct LocationModel: Codable {
    /// Name of character place of birth
    var name: String?
    /// URL of place of birth
    var url: String?
}

//
//  CharacterFullInfoModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

// MARK: - CharacterFullInfoModel
/// Model to work with full character information
struct CharacterFullInfoModel: Codable {
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
    var origin: Location
    /// Character image
    var image: String
    /// Episodes, where character appeared
    var episode: [CharacterEpisodesModel]

    private enum CodingKeys: String, CodingKey {
        case id, name, type, gender, origin, image, episode
        case aliveStatus = "status"
        case creatureType = "species"
    }

    init(model: CharacterInfoModel, origin: Location, episodes: [CharacterEpisodesModel]) {
        self.id = model.id
        self.name = model.name
        self.aliveStatus = model.aliveStatus
        self.creatureType = model.creatureType
        self.type = model.type
        self.gender = model.gender
        self.origin = origin
        self.image = model.image
        self.episode = episodes
    }
}

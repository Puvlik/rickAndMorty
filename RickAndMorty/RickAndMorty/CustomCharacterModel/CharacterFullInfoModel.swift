//
//  CharacterFullInfoModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

struct CharacterFullInfoModel: Codable {
    var id: Int
    var name: String
    var aliveStatus: String
    var creatureType: String
    let type: String
    var gender: String
    var origin: Location
    var image: String
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

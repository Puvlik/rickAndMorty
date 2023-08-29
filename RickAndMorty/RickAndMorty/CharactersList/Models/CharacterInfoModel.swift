//
//  CharacterInfoModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation

struct AllCharactersInfoModel: Codable {
    var results: [CharacterInfoModel]?
}

struct CharacterInfoModel: Codable {
    var id: Int
    var name: String
    var aliveStatus: String
    var creatureType: String
    let type: String
    var gender: String
    var origin: LocationModel
    var image: String
    var episode: [String]

    private enum CodingKeys: String, CodingKey {
        case id, name, type, gender, origin, image, episode
        case aliveStatus = "status"
        case creatureType = "species"
    }
}

struct LocationModel: Codable {
    var name: String?
    var url: String?
}

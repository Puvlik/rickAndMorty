//
//  CharacterEpisodesModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

struct CharacterEpisodesModel: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String

    private enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}

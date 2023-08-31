//
//  CharacterEpisodesModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

// MARK: - CharacterEpisodesModel
/// Model for fetching all episodes, where character appeared
struct CharacterEpisodesModel: Codable {
    /// Episode id
    let id: Int
    /// Episode title
    let name: String
    /// Episode date of creation
    let airDate: String
    /// Episode number in season
    let episode: String

    private enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}

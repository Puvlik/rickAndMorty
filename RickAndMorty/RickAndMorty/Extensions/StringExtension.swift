//
//  StringExtension.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 28.08.23.
//

import Foundation

extension String {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }

    func convertToEpisode() -> String {
        var seasonString = ""
        var episodeString = ""

        if let index = self.index(of: "E") {
            let season = self[..<index]
            seasonString = String(season)
            seasonString.remove(at: seasonString.startIndex)

            let episode = self[index...]
            episodeString = String(episode)
            episodeString.remove(at: episodeString.startIndex)
        }

        guard let episodeNumber = Int(episodeString),
              let seasonNumber = Int(seasonString) else { return "Unknown" }
        return "Episode: \(episodeNumber), Season: \(seasonNumber)"
    }
}

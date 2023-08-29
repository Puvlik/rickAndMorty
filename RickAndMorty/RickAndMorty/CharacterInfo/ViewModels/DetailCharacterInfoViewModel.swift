//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import Foundation
import UIKit

class DetailCharacterInfoViewModel {
    var characterOriginModel: Location?
    var characterEpisodesArray = [CharacterEpisodesModel]()

    func parseCharacterOrigin(originString: String, completion: @escaping () -> ()) {
        guard let url = URL(string: originString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let data = data, let self = self else { return }
                do {
                    let origin = try JSONDecoder().decode(Location.self, from: data)
                    self.characterOriginModel = origin
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    func parseAllCharacterEpisodes(episodes: [String], completion: @escaping () -> ()) {
        guard !episodes.isEmpty else { return }
        episodes.enumerated().forEach {
            guard let episodeURL = URL(string: $0.element) else { return }
            URLSession.shared.dataTask(with: episodeURL) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    do {
                        let episode = try JSONDecoder().decode(CharacterEpisodesModel.self, from: data)
                        self?.characterEpisodesArray.append(episode)
                        if self?.characterEpisodesArray.count == episodes.count {
                            completion()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}

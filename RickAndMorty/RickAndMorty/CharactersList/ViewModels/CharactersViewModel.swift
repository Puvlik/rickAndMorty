//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import UIKit

// MARK: - CharactersViewModel
/// Service to work with all characters request
final class CharactersViewModel {
    /// All characters URL
    private let urlString = "https://rickandmortyapi.com/api/character"
    /// List of all fetched characters
    var charactersListArray: AllCharactersInfoModel?

    /// Method of fetching all characters
    func loadAllCharactersInfo(completion: @escaping () -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let data = data, let self = self else { return }
                do {
                    let info = try JSONDecoder().decode(AllCharactersInfoModel.self, from: data)
                    self.charactersListArray = info
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

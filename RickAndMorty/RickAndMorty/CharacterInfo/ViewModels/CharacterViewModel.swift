//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 24.08.23.
//

import UIKit
import Foundation

class CharacterViewModel {
    func getImageFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { _, _, error in
            DispatchQueue.main.async {
                do {
                    let imageData = try Data(contentsOf: imageURL, options: [])
                    let characterImage = UIImage(data: imageData) ?? UIImage()
                    completion(characterImage)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

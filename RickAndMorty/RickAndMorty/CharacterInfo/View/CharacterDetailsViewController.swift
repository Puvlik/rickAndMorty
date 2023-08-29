//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import UIKit

private enum Constants {
    static var collectionViewItemSpacing: CGFloat { 10 }
    static var collectionViewLineSpacing: CGFloat { 10 }
    static var collectionViewWidthPadding: CGFloat { 40 }
    static var collectionViewHeightPadding: CGFloat { 220 }
    static var defaultPadding8: CGFloat { 8 }

    static var collectionViewDefaultColor: UIColor { .clear }
    static var collectionViewMainCellIdentifier: String { "CharacterMainInformationCell" }
    static var collectionViewInfoCellIdentifier: String { "CharacterInfoCollectionViewCell" }
    static var collectionViewOriginCellIdentifier: String { "CharacterOriginCollectionCell" }
    static var collectionViewEpisodeCellIdentifier: String { "EpisodeCollectionCell" }
}

class CharacterDetailsViewController: UIViewController {
    private lazy var characterDetailInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        layout.minimumLineSpacing = Constants.collectionViewLineSpacing
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - Constants.collectionViewWidthPadding,
                                 height: Constants.collectionViewHeightPadding)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = Constants.collectionViewDefaultColor
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private let viewModel: DetailCharacterInfoViewModel
    private let character: CharacterInfoModel
    private var fullCharacterInfoModel: CharacterFullInfoModel?

    init(character: CharacterInfoModel, viewModel: DetailCharacterInfoViewModel) {
        self.character = character
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().backgroundColor
        setupCollectionView()
    }

    private func fetchRequiredData() {
        let group = DispatchGroup()

        group.enter()
        viewModel.parseAllCharacterEpisodes(episodes: character.episode) {
            group.leave()
        }

        group.enter()
        viewModel.parseCharacterOrigin(originString: character.origin.url ?? "") {
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            guard let character = self?.character,
                  let origin = self?.viewModel.characterOriginModel,
                  let episodes = self?.viewModel.characterEpisodesArray else { return }
            self?.fullCharacterInfoModel = CharacterFullInfoModel(
                model: character,
                origin: origin,
                episodes: episodes)
            self?.characterDetailInfoCollectionView.reloadData()
        }
    }

    private func registedCollectionViewCells() {
        characterDetailInfoCollectionView.register(CharacterMainInformationCollectionViewCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewMainCellIdentifier)
        characterDetailInfoCollectionView.register(CharacterInfoCollectionViewCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewInfoCellIdentifier)
        characterDetailInfoCollectionView.register(CharacterOriginCollectionCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewOriginCellIdentifier)
        characterDetailInfoCollectionView.register(EpisodeCollectionCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewEpisodeCellIdentifier)
    }

    private func setupCollectionView() {
        registedCollectionViewCells()
        characterDetailInfoCollectionView.dataSource = self
        characterDetailInfoCollectionView.delegate = self

        view.addSubview(characterDetailInfoCollectionView)

        characterDetailInfoCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                               constant: topBarHeight).isActive = true
        characterDetailInfoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.defaultPadding8).isActive = true
        characterDetailInfoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -Constants.defaultPadding8).isActive = true
        characterDetailInfoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension CharacterDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionViewMainCellIdentifier,
                for: indexPath
            ) as? CharacterMainInformationCollectionViewCell else { return UICollectionViewCell() }
            cell.data = fullCharacterInfoModel
            if let imageURL = URL(string: fullCharacterInfoModel?.image ?? "") {
                let characterImage = KF.ImageResource(downloadURL: imageURL)
                cell.characterImageView.kf.setImage(with: characterImage)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionViewInfoCellIdentifier,
                for: indexPath
            ) as? CharacterInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.data = fullCharacterInfoModel
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionViewOriginCellIdentifier,
                for: indexPath
            ) as? CharacterOriginCollectionCell else { return UICollectionViewCell() }
            cell.data = fullCharacterInfoModel?.origin
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionViewEpisodeCellIdentifier,
                for: indexPath
            ) as? EpisodeCollectionCell else { return UICollectionViewCell() }

            cell.data = fullCharacterInfoModel?.episode[indexPath.row]
            return cell
        }
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        var cellHeight = 0.0
        switch indexPath.row {
        case 0:
            cellHeight = Constants.collectionViewHeightPadding
        case 1:
            cellHeight = 124
        case 2:
            cellHeight = 80
        default:
            cellHeight = 86
        }

        return CGSize(
            width: UIScreen.main.bounds.width - Constants.collectionViewWidthPadding,
            height: cellHeight
        )
    }
}

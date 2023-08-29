//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import Kingfisher
import UIKit

private enum Constants {
    static var collectionViewNumberOfSections: Int { 1 }
    static var defaultNumberOfCells: Int { 6 }

    static var collectionViewSectionTitleCellHeight: CGFloat { 35 }
    static var collectionViewMainCellHeight: CGFloat { 220 }
    static var collectionViewInfoCellHeight: CGFloat { 124 }
    static var collectionViewOriginCellHeight: CGFloat { 80 }
    static var collectionViewEpisodeCellHeight: CGFloat { 86 }

    static var collectionViewItemSpacing: CGFloat { 10 }
    static var collectionViewLineSpacing: CGFloat { 10 }
    static var collectionViewWidthPadding: CGFloat { 40 }
    static var defaultPadding8: CGFloat { 8 }

    static var collectionViewDefaultColor: UIColor { .clear }
    static var collectionViewMainCellIdentifier: String { "CharacterMainInformationCell" }
    static var collectionViewInfoCellIdentifier: String { "CharacterInfoCollectionViewCell" }
    static var collectionViewOriginCellIdentifier: String { "CharacterOriginCollectionCell" }
    static var collectionViewEpisodeCellIdentifier: String { "EpisodeCollectionCell" }
    static var collectionViewSectionTitleCellIdentifier: String { "SectionTitleCollectionViewCell" }
}

class CharacterDetailsViewController: UIViewController {
    private lazy var characterDetailInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        layout.minimumLineSpacing = Constants.collectionViewLineSpacing
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
        fetchRequiredData()
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
                episodes: episodes.sorted { $0.id < $1.id })
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
        characterDetailInfoCollectionView.register(SectionTitleCollectionViewCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewSectionTitleCellIdentifier)
    }

    private func setupCollectionView() {
        registedCollectionViewCells()
        characterDetailInfoCollectionView.dataSource = self
        characterDetailInfoCollectionView.delegate = self

        view.addSubview(characterDetailInfoCollectionView)

        characterDetailInfoCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                               constant: Constants.defaultPadding8).isActive = true
        characterDetailInfoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.defaultPadding8).isActive = true
        characterDetailInfoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -Constants.defaultPadding8).isActive = true
        characterDetailInfoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupSectionCollectionViewCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = characterDetailInfoCollectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionViewSectionTitleCellIdentifier,
            for: indexPath
        ) as? SectionTitleCollectionViewCell else { return UICollectionViewCell() }
        switch indexPath.row {
        case 1:
            cell.title = .info
        case 3:
            cell.title = .origin
        default:
            cell.title = .episodes
        }
        return cell
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate {}

extension CharacterDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.collectionViewNumberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let episodesCount = fullCharacterInfoModel?.episode.count else {
            return Constants.defaultNumberOfCells
        }

        return episodesCount + Constants.defaultNumberOfCells
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
        case 1, 3, 5:
            return setupSectionCollectionViewCell(indexPath: indexPath)
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionViewInfoCellIdentifier,
                for: indexPath
            ) as? CharacterInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.data = fullCharacterInfoModel
            return cell
        case 4:
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
            cell.data = fullCharacterInfoModel?.episode[indexPath.row - Constants.defaultNumberOfCells]
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
        case 1, 3, 5:
            cellHeight = Constants.collectionViewSectionTitleCellHeight
        case 0:
            cellHeight = Constants.collectionViewMainCellHeight
        case 2:
            cellHeight = Constants.collectionViewInfoCellHeight
        case 4:
            cellHeight = Constants.collectionViewOriginCellHeight
        default:
            cellHeight = Constants.collectionViewEpisodeCellHeight
        }

        return CGSize(
            width: UIScreen.main.bounds.width - Constants.collectionViewWidthPadding,
            height: cellHeight
        )
    }
}

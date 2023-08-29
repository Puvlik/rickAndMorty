//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import Kingfisher
import UIKit

private enum Constants {
    static var emptyCollection: Int { 0 }

    static var collectionViewItemSpacing: CGFloat { 16 }
    static var collectionViewLineSpacing: CGFloat { 16 }
    static var defaultPadding16: CGFloat { 16 }
    static var collectionViewHeightPadding: CGFloat { 64 }
    static var collectionViewSidePadding8: CGFloat { 8 }

    static var collectionViewDeaultColor: UIColor { .clear }

    static var collectionViewCellIdentifier: String { "CharacterCollectionCell" }
    static var navigationItemText: String { "Characters" }
}

class AllCharactersViewController: UIViewController {
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        layout.minimumLineSpacing = Constants.collectionViewLineSpacing
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - Constants.defaultPadding16,
                                 height: UIScreen.main.bounds.height / 4)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = Constants.collectionViewDeaultColor
        collection.register(CharacterCollectionCell.self,
                            forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private let viewModel: CharactersViewModel

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.loadAllCharactersInfo(completion: {
                self?.charactersCollectionView.reloadData()
            })
        }
        view.backgroundColor = UIColor().backgroundColor

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.navigationItemText

        setupCollectionView()
    }

    private func setupCollectionView() {
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        view.addSubview(charactersCollectionView)

        charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                      constant: topBarHeight).isActive = true
        charactersCollectionView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: Constants.collectionViewSidePadding8).isActive = true
        charactersCollectionView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -Constants.collectionViewSidePadding8).isActive = true
        charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AllCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCharacter = viewModel.charactersListArray?.results?[indexPath.row] else { return }
        let characterDetailedInfoViewController = CharacterDetailsViewController(
            character: selectedCharacter, viewModel: DetailCharacterInfoViewModel())
        self.present(characterDetailedInfoViewController, animated: true)
    }
}

extension AllCharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersListArray?.results?.count ?? Constants.emptyCollection
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionViewCellIdentifier,
            for: indexPath
        ) as? CharacterCollectionCell else { return UICollectionViewCell() }

        if let currentCharacter = viewModel.charactersListArray?.results?[indexPath.row] {
            cell.data = currentCharacter
            if let imageURL = URL(string: currentCharacter.image) {
                let characterImage = KF.ImageResource(downloadURL: imageURL)
                cell.characterImageView.kf.setImage(with: characterImage)
            }
        }
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

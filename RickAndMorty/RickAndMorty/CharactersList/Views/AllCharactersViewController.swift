//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import UIKit
import Foundation

private enum Constants {
    static var emptyCollection: Int { 0 }
    
    static var collectionViewItemSpacing: CGFloat { 16 }
    static var collectionViewLineSpacing: CGFloat { 16 }
    static var collectionViewWidthPadding: CGFloat { 16 }
    static var collectionViewHeightPadding: CGFloat { 32 }
    static var collectionViewDefaultSidePadding: CGFloat { 8 }
    
    static var collectionViewDeaultColor: UIColor { .clear }
    static var collectionViewCellIdentifier: String { "characterCell" }
    static var navigationItemText: String { "Characters" }
}

class AllCharactersViewController: UIViewController {

    private lazy var charactersCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        layout.minimumLineSpacing = Constants.collectionViewLineSpacing
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - Constants.collectionViewWidthPadding,
                                 height: UIScreen.main.bounds.height / 3 - Constants.collectionViewHeightPadding)
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
            self?.viewModel.loadAllCharactersInfo()
        }
        view.backgroundColor = UIColor().backgroundColor
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.navigationItemText
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.charactersCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        view.addSubview(charactersCollectionView)
        
        charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight).isActive = true
        charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.collectionViewDefaultSidePadding).isActive = true
        charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -Constants.collectionViewDefaultSidePadding).isActive = true
        charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AllCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TAPPED")
    }
}

extension AllCharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        // return viewModel.charactersListArray?.results?.count ?? Constants.emptyCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionViewCellIdentifier,
            for: indexPath
        ) as? CharacterCollectionCell else { return UICollectionViewCell() }

        if let currentCharacter = viewModel.charactersListArray?.results?[indexPath.row] {
            cell.data = currentCharacter
            viewModel.getImageFromURL(url: currentCharacter.image) { image in
                cell.characterImageView.image = image
            }
        }
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
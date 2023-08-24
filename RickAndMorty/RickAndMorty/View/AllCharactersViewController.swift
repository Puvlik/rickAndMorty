//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Паша Клопот on 21.08.23.
//

import Foundation
import UIKit

class AllCharactersViewController: UIViewController {
    
    private lazy var myCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 16, height: UIScreen.main.bounds.height / 3 - 32)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: "characterCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let viewModel: CharactersViewModel?
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().backgroundColor
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Characters"
        
        setupCollectionView()
        // viewModel?.fetchData(type: .characters, completion: {})
    }
    
    
    private func setupCollectionView() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView)
        
        myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AllCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AllCharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath)
        guard let realCell = cell as? CharacterCollectionCell else { return UICollectionViewCell() }
        realCell.data = viewModel?.character
        return realCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        myCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

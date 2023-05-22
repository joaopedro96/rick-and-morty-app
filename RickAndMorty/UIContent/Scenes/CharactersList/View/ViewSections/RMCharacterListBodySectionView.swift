//
//  RMCharacterListBodySectionView.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

protocol RMCharacterListBodySectionViewDelegate: AnyObject {
    func didTapCharacter(_ characterData: RMCharacterDetailResponse)
}

final class RMCharacterListBodySectionView: UIView {
    
    // MARK: - PROPERTIES
    
    private var characterListData: [RMCharacterDetailResponse]?
    weak var delegate: RMCharacterListBodySectionViewDelegate?
    var shouldShowLoading: Bool = false {
        didSet {
            collectionView.performBatchUpdates { }
        }
    }
    
    // MARK: - INITIALIZER
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var collectionView: RMDynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let setupComponent = RMDynamicHeightCollectionView(frame: .zero,
                                                           collectionViewLayout: layout)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.showsVerticalScrollIndicator = false
        setupComponent.isScrollEnabled = false
        setupComponent.delegate = self
        setupComponent.dataSource = self
        setupComponent.isUserInteractionEnabled = true
        setupComponent.register(RMCharacterListViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterListViewCell.cellIdentifier)
        setupComponent.register(RMCharacterListFooterReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMCharacterListFooterReusableView.identifier)
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func updateSection(with data: RMCharacterListResponse) {
        characterListData = data.results
        collectionView.reloadData()
    }
    
    func updateCharacterNextPage(with data: RMCharacterListResponse) {
        guard let indexPathArray = getIndexPathArray(for: data.results) else { return }
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: indexPathArray)
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getIndexPathArray(for newData: [RMCharacterDetailResponse]) -> [IndexPath]? {
        guard let characterList = characterListData else { return nil }
        let currentIndex = characterList.count
        characterListData?.append(contentsOf: newData)
        guard let newCount = characterListData?.count else { return nil }
        var indexPathArray: [IndexPath] = []
        
        for index in currentIndex ..< newCount {
            indexPathArray.append(IndexPath(row: index, section: 0))
        }
        
        return indexPathArray
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - EXTENSIONS

extension RMCharacterListBodySectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterListData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterListViewCell.cellIdentifier,
            for: indexPath)
        guard let collectionCell = cell as? RMCharacterListViewCell,
              let data = characterListData?[indexPath.row] else { return cell }
        collectionCell.updateCell(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let relativeWidth = (bounds.width - 20 - 10) / 2
        let relativeHeight = relativeWidth * 1.3
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let selectedCharacter = characterListData?[indexPath.row] else { return }
        delegate?.didTapCharacter(selectedCharacter)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMCharacterListFooterReusableView.identifier,
            for: indexPath)
        
        guard let footer = reusableView as? RMCharacterListFooterReusableView else {
            return UICollectionReusableView()
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoading else { return .zero }
        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
}

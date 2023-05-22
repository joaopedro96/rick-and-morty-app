//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import Foundation

final class RMCharacterDetailViewModel: RMCharacterDetailViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    weak var viewController: RMCharacterDetailViewControllerProtocol?
    private let characterData: RMCharacterDetailResponse
    var viewState: RMCharacterDetailViewState = .isEmpty {
        didSet {
            viewController?.updateState(with: viewState)
        }
    }
    
    // MARK: - INITIALIZER
    
    init(characterData: RMCharacterDetailResponse) {
        self.characterData = characterData
    }
    
    // MARK: - PUBLIC METHODS
    
    func initState() {
        viewState = .hasData(characterData)
    }
}

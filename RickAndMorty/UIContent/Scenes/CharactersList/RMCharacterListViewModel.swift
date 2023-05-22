//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation

final class RMCharacterListViewModel: RMCharacterListViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    private let service: RMServiceManagerProtocol
    weak var viewController: RMCharacterListViewControllerProtocol?
    var viewState: RMCharacterListViewState = .isEmpty {
        didSet {
            viewController?.updateState(with: viewState)
        }
    }
    
    // MARK: - INITIALIZER
    
    init(service: RMServiceManagerProtocol) {
        self.service = service
    }
    
    // MARK: - PUBLIC METHODS
    
    func initState() {
        viewState = .isLoading
        fetchCharacterData()
    }
    
    func getNextPageData(with url: String) {
        fetchNextPageData(with: url)
    }
    
    // MARK: - FETCH METHODS
    
    private func fetchCharacterData() {
        service.execute(request: RMRequest.character) { [weak self] (result: Result<RMCharacterListResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState = .hasData(data)
                case .failure:
                    self?.viewState = .hasError
            }
        }
    }
    
    private func fetchNextPageData(with url: String) {
        service.execute(request: RMRequest.nextPage(url: url)) { [weak self] (result: Result<RMCharacterListResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState = .hasNextPageData(data)
                case .failure:
                    self?.viewState = .hasError
            }
        }
    }
}

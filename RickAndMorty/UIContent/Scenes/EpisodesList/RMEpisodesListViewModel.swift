//
//  RMEpisodesListViewModel.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import Foundation

final class RMEpisodesListViewModel: RMEpisodesListViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    private let service: RMServiceManagerProtocol
    weak var viewController: RMEpisodesListViewControllerProtocol?
    var viewState: RMEpisodesListViewState = .isEmpty {
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
        service.execute(request: RMRequest.episode) { [weak self] (result: Result<RMEpisodeListResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState = .hasData(data)
                case .failure:
                    self?.viewState = .hasError
            }
        }
    }
    
    private func fetchNextPageData(with url: String) {
        service.execute(request: RMRequest.nextPage(url: url)) { [weak self] (result: Result<RMEpisodeListResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState = .hasNextPageData(data)
                case .failure:
                    self?.viewState = .hasError
            }
        }
    }
}

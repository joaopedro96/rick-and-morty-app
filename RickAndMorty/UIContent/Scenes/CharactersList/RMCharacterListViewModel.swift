//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation
import RxSwift

final class RMCharacterListViewModel: RMCharacterListViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    private let service: RMServiceManagerProtocol
    private let disposeBag = DisposeBag()
    let viewState = BehaviorSubject<RMCharacterListViewState>(value: .isEmpty)
    
    // MARK: - INITIALIZER
    
    init(service: RMServiceManagerProtocol) {
        self.service = service
    }
    
    // MARK: - PUBLIC METHODS
    
    func initState() {
        viewState.onNext(.isLoading)
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
                    self?.viewState.onNext(.hasData(data))
                case .failure:
                    self?.viewState.onNext(.hasError)
            }
        }
    }
    
    private func fetchNextPageData(with url: String) {
        service.execute(request: RMRequest.nextPage(url: url)) { [weak self] (result: Result<RMCharacterListResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState.onNext(.hasNextPageData(data))
                case .failure:
                    self?.viewState.onNext(.hasError)
            }
        }
    }
}

//
//  RMFlowManager.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import UIKit

final class RMFlowManager: UINavigationController, RMFactoryProtocol {
    
    // MARK: - PROPERTIES
    
    var tabBarNavControllers: [UINavigationController] = []
    
    // MARK: - PUBLIC METHODS
    
    func makeCharacterListViewController() -> RMCharacterListViewController {
        let characterViewModel = RMCharacterListViewModel(service: RMServiceManager.shared)
        let viewController = RMCharacterListViewController(viewModel: characterViewModel)
        viewController.delegate = self
        return viewController
    }

    func makeEpisodesListViewController() -> RMEpisodesListViewController {
        let episodeViewModel = RMEpisodesListViewModel(service: RMServiceManager.shared)
        let viewController = RMEpisodesListViewController(viewModel: episodeViewModel)
        episodeViewModel.viewController = viewController
        viewController.delegate = self
        return viewController
    }
    
    func makeCharacterDetailViewController(with data: RMCharacterDetailResponse) -> RMCharacterDetailViewController {
        let detailViewModel = RMCharacterDetailViewModel(characterData: data)
        let viewController = RMCharacterDetailViewController(viewModel: detailViewModel)
        detailViewModel.viewController = viewController
        viewController.delegate = self
        return viewController
    }
}

// MARK: - EXTENSIONS

extension RMFlowManager: RMCharacterListViewControllerDelegate {
    func goToCharacterDetailPage(with characterData: RMCharacterDetailResponse, from tabIndex: Int) {
        let vc = makeCharacterDetailViewController(with: characterData)
        tabBarNavControllers[tabIndex].pushViewController(vc, animated: true)
    }
}

extension RMFlowManager: RMCharacterDetailViewControllerDelegate {
    func didTapGoBack(from tabIndex: Int) {
        tabBarNavControllers[tabIndex].popViewController(animated: true)
    }
}

extension RMFlowManager: RMEpisodesListViewControllerDelegate {
    func goToEpisodeDetailPage(from tabIndex: Int) {
        let vc = ExampleViewController()
        tabBarNavControllers[tabIndex].pushViewController(vc, animated: true)
    }
}

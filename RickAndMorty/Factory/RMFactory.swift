//
//  RMFactory.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation

protocol RMFactoryProtocol {    
    func makeCharacterListViewController() -> RMCharacterListViewController
    
    func makeCharacterDetailViewController(with data: RMCharacterDetailResponse) -> RMCharacterDetailViewController
    
    func makeEpisodesListViewController() -> RMEpisodesListViewController
}

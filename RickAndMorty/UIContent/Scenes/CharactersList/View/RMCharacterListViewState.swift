//
//  RMCharacterListViewState.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation

enum RMCharacterListViewState {
    case isEmpty
    case hasData(RMCharacterListResponse)
    case hasNextPageData(RMCharacterListResponse)
    case isLoading
    case hasError
}

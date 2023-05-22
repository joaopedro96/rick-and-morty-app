//
//  RMEpisodesListViewState.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import Foundation

enum RMEpisodesListViewState {
    case isEmpty
    case hasData(RMEpisodeListResponse)
    case hasNextPageData(RMEpisodeListResponse)
    case hasError
    case isLoading
}

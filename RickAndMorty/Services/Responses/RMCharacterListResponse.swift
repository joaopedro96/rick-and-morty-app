//
//  RMCharacterListResponse.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import Foundation

struct RMCharacterListResponse: Codable {
    let info: RMInfoObject
    let results: [RMCharacterDetailResponse]
}

struct RMInfoObject: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

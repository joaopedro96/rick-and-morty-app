//
//  RMEpisodeListResponse.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 21/05/23.
//

import Foundation

struct RMEpisodeListResponse: Codable {
    let info: RMInfoObject
    let results: [RMEpisodeDetailResponse]
}

struct RMEpisodeDetailResponse: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}

//
//  RMCharacterDetailResponse.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import UIKit

struct RMCharacterDetailResponse: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMLocationObjetc
    let location: RMLocationObjetc
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var tagColor: UIColor {
        switch self {
            case .alive: return .green100
            case .dead: return .red100
            case .unknown: return .purple100
        }
    }
    
    var textColor: UIColor {
        switch self {
            case .alive: return .green200
            case .dead: return .red200
            case .unknown: return .purple200
        }
    }
}

enum RMCharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}

struct RMLocationObjetc: Codable {
    let name: String
    let url: String
}

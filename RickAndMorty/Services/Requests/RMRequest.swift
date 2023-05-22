//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import Foundation
import Alamofire

enum RMRequest: RMServiceRequestProtocol {
    
    case character
    case episode
    case nextPage(url: String)
    
    var path: String {
        switch self {
            case .character: return "https://rickandmortyapi.com/api/character"
            case .episode: return "https://rickandmortyapi.com/api/episode"
            case .nextPage(let urlPath): return urlPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
            default: return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            default: return nil
        }
    }
}

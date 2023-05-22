//
//  RMServiceRequestProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation
import Alamofire

protocol RMServiceRequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

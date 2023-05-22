//
//  RMServiceManagerProtocol.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 20/05/23.
//

import Foundation

protocol RMServiceManagerProtocol {
    func execute<T: Decodable>(request: RMServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void)
}

//
//  RMServiceManager.swift
//  RickAndMorty
//
//  Created by João Pedro da Mata Gonçalves Ribeiro on 19/05/23.
//

import Foundation
import Alamofire

final class RMServiceManager: RMServiceManagerProtocol {
    
    static let shared = RMServiceManager()
    
    func execute<T: Decodable>(request: RMServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(request.path,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).response { response in
            switch response.result {
                    
                case .success(let data):
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getStatusCode(request: RMServiceRequestProtocol, completion: @escaping ((Int?) -> Void)) {
        AF.request(request.path,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers).response { response in
            completion(response.response?.statusCode)
        }
    }
}

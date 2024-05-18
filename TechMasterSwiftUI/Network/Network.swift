//
//  Network.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Combine
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case unknownError
}

class Network {
    
    static let shared = Network()
    private init() { }
    
}

extension Network {
    
    func myAPICall<T: Decodable>(model: T.Type, router: TargetType) async throws -> AnyPublisher<T, NetworkError> {

        return AF.request(try! router.asURLRequest())
            .publishDecodable(type: T.self)
            .value()
            .mapError { _ in
                NetworkError.unknownError
            }
            .eraseToAnyPublisher()
    }

    
}

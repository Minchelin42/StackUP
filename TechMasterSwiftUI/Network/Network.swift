//
//  Network.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Combine
import Alamofire

struct TopMoviesDataModel: Decodable,Identifiable {
    var id = UUID()
    let items: [Int]?
    let errorMessage: String?
    enum CodingKeys : String, CodingKey{
        case items,errorMessage
    }
}
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
    
    func myAPICall<T: Decodable>(model: T.Type, router: NetworkRouter) async throws -> AnyPublisher<T, NetworkError> {

        return AF.request(try! router.asURLRequest())
            .publishDecodable(type: T.self)
            .value()
            .mapError { _ in
                NetworkError.unknownError
            }
            .eraseToAnyPublisher()
    }

    
}

//
//  NetworkType.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/30.
//

import Foundation
import Combine
import Alamofire

protocol NetworkType {
    func myAPICall<T: Decodable>(model: T.Type, router: TargetType, completion: @escaping (T) -> Void)
    func multipartAPICall<T: Decodable>(model: T.Type, router: TargetType, query: ProfileQuery) -> AnyPublisher<T, NetworkError>
}

class NetworkProvider: NetworkType {
    func myAPICall<T: Decodable>(model: T.Type, router: TargetType, completion: @escaping (T) -> Void) {
        do {
            let urlRequest = try router.asURLRequest()
            
            AF.request(urlRequest)
                .validate(statusCode: 200..<420)
                .responseDecodable(of: model.self) { response in
                    switch response.result {
                    case .success(let likeModel):
                        completion(likeModel)
                    case .failure(let error):
                        if let code = response.response?.statusCode {
                            print("에러코드 \(code)")
                        }
                        print(error)
                    }
                }
            
        } catch {
            print("myAPICall Error")
        }
    }
    
    func multipartAPICall<T: Decodable>(model: T.Type, router: TargetType, query: ProfileQuery) -> AnyPublisher<T, NetworkError> {
        do {
            let urlRequest = try router.asURLRequest()
            return AF.upload(multipartFormData: { multipartFormData in
                if let nick = query.nick.data(using: .utf8) {
                    multipartFormData.append(nick, withName: "nick")
                }
            }, with: urlRequest)
            .publishDecodable(type: T.self)
            .value()
            .mapError { error in
                NetworkError.unknownError
            }
            .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
    }
}

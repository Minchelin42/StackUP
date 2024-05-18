//
//  UserRouter.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation
import Alamofire

enum UserRouter {
    case join(query: JoinQuery)
    case login(query: LoginQuery)
    case emailValidation(query: IdValidationQuery)
    case withdraw
    case renewToken
}

struct MessageModel: Decodable {
    let message: String
}

extension UserRouter: TargetType {

    var baseURL: String {
        return APIKey.baseURL.rawValue
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .join, .login, .emailValidation:
            return .post
        case .withdraw, .renewToken:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .join:
            return "/users/join"
        case .login:
            return "/users/login"
        case .emailValidation:
            return "/validation/email"
        case .withdraw:
            return "/users/withdraw"
        case .renewToken:
            return "/auth/refresh"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .join, .login, .emailValidation:
            return [HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue]
        case .withdraw:
            return [HTTPHeader.authorization.rawValue: NowUser.accessToken,
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue]
        case .renewToken:
            return [HTTPHeader.authorization.rawValue: NowUser.accessToken,
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue,
                    HTTPHeader.refresh.rawValue : NowUser.accessToken]
        }
    }
    
    var parameters: String? {
       return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .join(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .login(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .emailValidation(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .withdraw, .renewToken:
            return nil
        }
    }

}

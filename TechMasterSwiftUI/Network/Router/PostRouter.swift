//
//  PostRouter.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Alamofire

enum PostRouter {
    case getPost(productID: String)
    case getThisPost(id: String)
    case scrap(postID: String, query: ScrapModel)
}

extension PostRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPost:
            return .get
        case .getThisPost:
            return .get
        case .scrap:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getPost:
            return "/posts"
        case .getThisPost(let id):
            return "/posts/\(id)"
        case .scrap(let postID, _):
            return "/posts/\(postID)/like"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .getPost, .getThisPost:
            return [ HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue,
                     HTTPHeader.authorization.rawValue : NowUser.accessToken]
        case .scrap:
            return [ HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
                HTTPHeader.sesacKey.rawValue: APIKey.sesacKey.rawValue,
                     HTTPHeader.authorization.rawValue: NowUser.accessToken]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPost(let productID):
            return [URLQueryItem(name: "product_id", value: productID)]
        default: return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .scrap(_, let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default: return nil
        }
    }
    
    
}

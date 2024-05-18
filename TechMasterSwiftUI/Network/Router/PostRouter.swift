//
//  PostRouter.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Alamofire

enum PostRouter {
    case getPost
    case getThisPost(id: String)
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
        }
    }
    
    var path: String {
        switch self {
        case .getPost:
            return "/posts"
        case .getThisPost(let id):
            return "/posts/\(id)"
        
        }
    }
    
    var header: [String : String] {
        switch self {
        case .getPost, .getThisPost:
            return [ HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue,
                     HTTPHeader.authorization.rawValue : UserDefaults.standard.string(forKey: "accessToken") ?? ""]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    
}

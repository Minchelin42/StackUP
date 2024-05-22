//
//  ProfileRouter.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/21.
//

import Foundation
import Alamofire

enum ProfileRouter {
    case myProfile
    case getScraplist
    case editProfile
}

extension ProfileRouter: TargetType {
    
    var baseURL: String {
        return APIKey.baseURL.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .myProfile:
            return .get
        case .getScraplist:
            return .get
        case .editProfile:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .myProfile:
            return "/users/me/profile"
        case .getScraplist:
            return "/posts/likes/me"
        case .editProfile:
            return "/users/me/profile"
        }
    }

    var header: [String : String] {
        
        switch self {
        case .myProfile:
            return [HTTPHeader.authorization.rawValue: NowUser.accessToken,
                    HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue]
        case .getScraplist:
            return [HTTPHeader.authorization.rawValue: NowUser.accessToken,
                    HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue]
        case .editProfile:
            return [HTTPHeader.authorization.rawValue: NowUser.accessToken,
                    HTTPHeader.contentType.rawValue: "multipart/form-data",
                    HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue]
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

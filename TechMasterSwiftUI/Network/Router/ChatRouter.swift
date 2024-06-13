//
//  ChatRouter.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/12.
//

import Foundation
import Alamofire

enum ChatRouter {
    case createChat
    case loadChatHistory(roomID: String)
    case sendMessage(roomID: String, query: SendModel)
}

extension ChatRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .createChat:
            return .post
        case .loadChatHistory:
            return .get
        case .sendMessage:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .createChat:
            return "/chats"
        case .loadChatHistory(let roomID):
            return "/chats/\(roomID)"
        case .sendMessage(let roomID, _):
            return "/chats/\(roomID)"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .loadChatHistory:
            return [HTTPHeader.sesacKey.rawValue : APIKey.sesacKey.rawValue,
                    HTTPHeader.authorization.rawValue : NowUser.accessToken]
        case .sendMessage, .createChat:
            return [ HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
                HTTPHeader.sesacKey.rawValue: APIKey.sesacKey.rawValue,
                     HTTPHeader.authorization.rawValue: NowUser.accessToken ]
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
        case .createChat:
            let encoder = JSONEncoder()
            return try? encoder.encode(ChatCreateQuery(opponentID: APIKey.serviceCenterID.rawValue))
        case .sendMessage(_, let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default: return nil
        }
    }
    
}

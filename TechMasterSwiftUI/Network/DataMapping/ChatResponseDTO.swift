//
//  ChatResponseDTO.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/11.
//

import Foundation

typealias ChatList = [ChatResponseDTO]

struct ChatHistoryDTO: ResponseDTOType {
    let data: ChatList
}

extension ChatHistoryDTO {
    func toDomain() -> ChatList {
        return self.data
    }
}

struct ChatUser: Decodable, Hashable {
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

struct ChatResponseDTO: ResponseDTOType {
    
    let content: String
    let createdAt: String
    let sender: ChatUser
    let files: [String]
 
    enum CodingKeys: String, CodingKey {
        case content
        case createdAt
        case sender
        case files
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.sender = try container.decodeIfPresent(ChatUser.self, forKey: .sender) ?? ChatUser(userID: "")
        self.files = try container.decodeIfPresent([String].self, forKey: .files) ?? []
    }
}

extension ChatResponseDTO {
    func toDomain() -> ChatModel {
        return ChatModel(content: content, createdAt: createdAt, sender: sender, files: files)
    }
}

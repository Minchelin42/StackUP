//
//  ChatModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/13.
//

import Foundation

struct ChatModel: Hashable {
    let content: String
    let createdAt: String
    let sender: ChatUser
    let files: [String]
}

struct ChatCreateQuery: Encodable {
    let opponentID: String
    
    enum CodingKeys: String, CodingKey {
        case opponentID = "opponent_id"
    }
}

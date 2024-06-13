//
//  CreateChatResponseDTO.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/13.
//

import Foundation

struct CreateChatModel {
    let roomID: String
    let createdAt: String
    let updatedAt: String
    let participants: [ChatUser]
}

struct CreateChatResponseDTO: ResponseDTOType {
    let roomID: String
    let createdAt: String
    let updatedAt: String
    let participants: [ChatUser]
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case createdAt
        case updatedAt
        case participants
    }
}

extension CreateChatResponseDTO {
    func toDomain() -> CreateChatModel {
        return CreateChatModel(roomID: roomID, createdAt: createdAt, updatedAt: updatedAt, participants: participants)
    }
}

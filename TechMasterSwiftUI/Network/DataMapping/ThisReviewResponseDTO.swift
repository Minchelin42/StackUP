//
//  ThisReviewResponseDTO.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

struct ThisReviewResponseDTO: ResponseDTOType {
    let id = UUID()
    let post_id: String
    let product_id: String
    let classTitle: String
    let review: String
    let classID: String
    let reviewer: Reviewer
    
    enum CodingKeys: String, CodingKey {
        case post_id
        case product_id
        case classTitle = "title"
        case review = "content"
        case classID = "content1"
        case reviewer = "creator"
    }

}

struct Reviewer: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
    
    enum CodingKeys: CodingKey {
        case user_id
        case nick
        case profileImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_id = try container.decode(String.self, forKey: .user_id)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
    }
}

extension ThisReviewResponseDTO {
    func toDomain() -> ReviewModel {
        return .init(post_id: post_id, product_id: product_id, classTitle: classTitle, review: review, classID: classID, reviewer: reviewer)
    }
}

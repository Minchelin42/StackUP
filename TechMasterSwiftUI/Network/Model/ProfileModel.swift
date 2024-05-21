//
//  ProfileModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/21.
//

import Foundation

struct ProfileModel: Decodable {
    let userID: String
    let id: String
    let nick: String
    let profileImage: String
    let review: [String]
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case id = "email"
        case nick
        case profileImage
        case review = "posts"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.id = try container.decode(String.self, forKey: .id)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
        self.review = try container.decode([String].self, forKey: .review)
    }
    
}

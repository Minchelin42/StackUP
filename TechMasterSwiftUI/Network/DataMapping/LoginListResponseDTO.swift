//
//  LoginResponseDTO+Mapping.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

struct LoginResponseDTO: ResponseDTOType {
    let user_id: String
    let id: String
    let nick: String
    let profileImage: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case user_id
        case id = "email"
        case nick
        case profileImage
        case accessToken
        case refreshToken
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_id = try container.decode(String.self, forKey: .user_id)
        self.id = try container.decode(String.self, forKey: .id)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}

extension LoginResponseDTO {
    func toDomain() -> LoginModel {
        print("LoginModel 바꾸는중")
        return .init(user_id: user_id, id: id, nick: nick, profileImage: profileImage, accessToken: accessToken, refreshToken: refreshToken)
    }
}

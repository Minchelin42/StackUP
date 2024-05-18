//
//  JoinModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation

struct JoinModel: Decodable {
    let user_id: String
    let id: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case user_id
        case id = "email"
        case nick
    }
}

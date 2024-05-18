//
//  JoinQuery.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation

struct JoinQuery: Encodable {
    let id: String
    let password: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "email"
        case password
        case nick
    }
}

//
//  LoginQuery.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation

struct LoginQuery: Encodable {
    let id: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id = "email"
        case password
    }
}

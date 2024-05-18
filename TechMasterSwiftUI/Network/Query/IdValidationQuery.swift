//
//  IdValidationQuery.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation

struct IdValidationQuery: Encodable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "email"
    }
}

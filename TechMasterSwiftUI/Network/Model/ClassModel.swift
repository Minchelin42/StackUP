//
//  PostModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation

typealias ClassList = [ClassModel]

struct GetClassModel: Decodable {
    let data: ClassList
    let next_cursor: String
}

struct ClassModel: Decodable {
    let post_id: String
    let product_id: String
    let className: String
    let price: String
    let classIntro: String
    let scrap: [String]
    
    enum CodingKeys: String, CodingKey {
        case post_id
        case product_id
        case className = "title"
        case price = "content"
        case classIntro = "content1"
        case scrap = "likes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.post_id = try container.decode(String.self, forKey: .post_id)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id) ?? ""
        self.className = try container.decodeIfPresent(String.self, forKey: .className) ?? ""
        self.price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        self.classIntro = try container.decodeIfPresent(String.self, forKey: .classIntro) ?? ""
        self.scrap = try container.decodeIfPresent([String].self, forKey: .scrap) ?? []
    }
}

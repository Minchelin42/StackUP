//
//  ThisClassResponseDTO.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

struct ThisClassResponseDTO: ResponseDTOType {
    let post_id: String
    let product_id: String
    let className: String
    let classIntro: String
    let price: String
    let category: String
    let scrap: [String]
    
    enum CodingKeys: String, CodingKey {
        case post_id
        case product_id
        case className = "title"
        case classIntro = "content1"
        case price = "content2"
        case category = "content3"
        case scrap = "likes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.post_id = try container.decode(String.self, forKey: .post_id)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id) ?? ""
        self.className = try container.decodeIfPresent(String.self, forKey: .className) ?? ""
        self.classIntro = try container.decodeIfPresent(String.self, forKey: .classIntro) ?? ""
        self.price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.scrap = try container.decodeIfPresent([String].self, forKey: .scrap) ?? []
    }

}

extension ThisClassResponseDTO {
    func toDomain() -> ClassModel {
        return .init(post_id: post_id, product_id: product_id, className: className, classIntro: classIntro, price: price, category: category, scrap: scrap)
    }
}

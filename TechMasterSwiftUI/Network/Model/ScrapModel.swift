//
//  ScrapQuery.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import Foundation

typealias ScrapQuery = ScrapModel

struct ScrapModel: Codable {
    var scrapStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case scrapStatus = "like_status"
    }
}

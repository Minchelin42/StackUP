//
//  ReviewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import Foundation

struct ReviewModel {
    let id = UUID()
    let post_id: String
    let product_id: String
    let classTitle: String
    let review: String
    let classID: String
    let reviewer: Reviewer
}




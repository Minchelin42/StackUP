//
//  ReviewResponseDTO+Mapping.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

typealias ReviewList = [ThisReviewResponseDTO]

struct ReviewListResponseDTO: ResponseDTOType {
    let data: ReviewList
    let next_cursor: String
}

extension ReviewListResponseDTO {
    func toDomain() -> ReviewList {
        return self.data
    }
}




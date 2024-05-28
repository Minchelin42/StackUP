//
//  ClassResponseDTO+Mapping.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

typealias ClassList = [ThisClassResponseDTO]

struct ClassListResponseDTO: ResponseDTOType {
    let data: ClassList
    let next_cursor: String
}

extension ClassListResponseDTO {
    
    func toDomain() -> ClassList {
        return self.data
    }
 
}

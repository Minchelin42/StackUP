//
//  ResponseDTOType.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/28.
//

import Foundation

protocol ResponseDTOType: Decodable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}

//
//  NowUser.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import Foundation

struct NowUser {
    @UserDefaultManager(key: UDKey.userID.rawValue, defaultValue: "")
    static var userID: String
    
    @UserDefaultManager(key: UDKey.accessToken.rawValue, defaultValue: "")
    static var accessToken: String
    
    @UserDefaultManager(key: UDKey.refreshToken.rawValue, defaultValue: "")
    static var refreshToken: String
}

enum UDKey: String {
    case userID = "userID"
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
}

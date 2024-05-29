//
//  AppRootManager.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/29.
//

import Foundation

enum AppRoot {
    case login
    case home
}

final class AppRootManager: ObservableObject {
    @Published var currentRoot: AppRoot = NowUser.isLogin ? .home : .login
}

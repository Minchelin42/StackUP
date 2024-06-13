//
//  Router.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/29.
//

import SwiftUI

public enum NextView: Hashable {
    case joinView
    case myPageView
    case editProfileView(nick: String, id: String, profileImg: String)
    case contentView
    case classDetailView(postID: String)
    case scrapListView
    case payListView
    case chatView
    case tabView
}

struct FeatureView: View {
    let type: NextView
    
    var body: some View {
        switch type {
        case .joinView:
            JoinView()
        case .myPageView:
            MyPageView()
        case .editProfileView(let nick, let id, let profileImg):
            EditProfileView(viewModel: EditProfileViewModel(nickname: nick, id: id, profileImg: profileImg))
        case .contentView:
            ContentView()
        case .classDetailView(let postID):
            ClassDetailView(viewModel: ClassDetailViewModel(postID: postID))
        case .scrapListView:
            MyClassListView()
        case .payListView:
            MyClassListView()
        case .chatView:
            ChatView()
        case .tabView:
            MyTabView()
        }
    }
}

public final class Router: ObservableObject {
    @Published public var route = NavigationPath()
    public init() { }
    
    @MainActor
    public func push<T: Hashable>(view: T) {
        route.append(view)
    }
    
    @MainActor
    public func pop() {
        route.removeLast()
    }
    
    @MainActor
    public func pop(depth: Int) {
        route.removeLast(depth)
    }
    
    @MainActor
    public func popToRoot() {
        route = NavigationPath()
    }
    
    @MainActor
    public func switchView<T: Hashable>(view: T) {
        guard !route.isEmpty else { return }
        print("뷰 바꾸는 중")
        var tempRoute = route
        tempRoute.removeLast()
        tempRoute.append(view)
        route = tempRoute
    }
    
}

//
//  NavigationLazyView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/16.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
    let build: () -> T
    
    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

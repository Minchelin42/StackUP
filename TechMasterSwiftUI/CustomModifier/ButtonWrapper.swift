//
//  ButtonWrapper.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/20.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
    }
    
}

extension View {
    
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
    
}

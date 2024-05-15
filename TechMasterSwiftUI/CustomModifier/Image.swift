//
//  Image.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

private struct setThumbnailImage: ViewModifier {

    let cornerRadius: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: height)
            .foregroundColor(MyColor.main)
            .background(Color.black)
            .cornerRadius(cornerRadius)
    }
    
}


extension View {
    func asLoadImage(cornerRadius: CGFloat, height: CGFloat) -> some View {
        modifier(setThumbnailImage(cornerRadius: cornerRadius, height: height))
    }
}


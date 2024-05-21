//
//  Extension + Image.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/21.
//

import SwiftUI

extension Image {
    func makeProfileImg(size: CGFloat) -> some View {
        self
            .resizable()
            .clipShape(Circle())
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(MyColor.lightGray, lineWidth: 1)
            )
       
    }
}

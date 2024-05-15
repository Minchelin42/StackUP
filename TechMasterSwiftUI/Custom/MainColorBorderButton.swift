//
//  MainColorBorderButton.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct MainColorBorderButton: View {
    
    let title: String
    let action: () -> Void
    let cornerRadius: CGFloat
    
    var body: some View {
        Button(action: action) {
                   Text(title)
                       .foregroundStyle(MyColor.main)
                       .font(.system(size: 13, weight: .medium))
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
               }
               .background(MyColor.white)
               .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
               .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(MyColor.main, lineWidth: 1))
           }
    }


#Preview {
    MainColorBorderButton(title: "회원가입", action: { print("액션") }, cornerRadius: 10)
}

//
//  MainColorButton.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct MainColorButton: View {
    
    let title: String
    let action: () -> Void
    let cornerRadius: CGFloat
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(MyColor.white)
                .font(.system(size: 13, weight: .medium))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .background(MyColor.main)
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    MainColorButton(title: "회원가입", action: { print("액션") }, cornerRadius: 10)
}

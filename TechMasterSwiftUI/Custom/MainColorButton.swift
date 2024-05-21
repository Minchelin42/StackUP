//
//  MainColorButton.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct MainColorButton: View {
    
    let title: String
    let cornerRadius: CGFloat
    let disabled: Bool
    
    var body: some View {
        Text(title)
            .foregroundStyle(MyColor.white)
            .font(.system(size: 13, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(disabled ? MyColor.lightGray : MyColor.main)
            .disabled(disabled)
            .cornerRadius(cornerRadius)
    }
}

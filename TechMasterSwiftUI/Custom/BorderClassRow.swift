//
//  BorderClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/22.
//

import SwiftUI

struct BorderClassRow: View {
    
    var categorySize: CGFloat
    var titleSize: CGFloat
    var height: CGFloat
    
    var category: String
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            MyImage.testImg.resizable().asLoadImage(cornerRadius: 0, height: height).padding(.bottom, 2)
            
            Text(category).font(.system(size: categorySize, weight: .semibold)).foregroundStyle(MyColor.darkGray)
                .padding(.leading, 8)
            Text(title)
                .blackMediumFont(size: titleSize).frame(height: titleSize * 2.8, alignment: .top).padding(.leading, 8)
            
        }
        .multilineTextAlignment(.leading)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(MyColor.lightGray, lineWidth: 1))
    }
}

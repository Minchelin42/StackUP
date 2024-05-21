//
//  MyReviewRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/19.
//

import SwiftUI

struct MyReviewRow: View {
    let title: String
    let content: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title).subtitleFont().multilineTextAlignment(.leading)
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(MyColor.main)
                    .wrapToButton {
                        action()
                    }
            }
            Text(content)
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(MyColor.darkGray)
        }
        .padding(16)
    }
}

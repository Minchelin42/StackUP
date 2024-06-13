//
//  ChatRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/10.
//

import SwiftUI

struct ChatRow: View {

    var content: String
    var isUser: Bool

    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            Text(content)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(MyColor.white)
                .padding(10)
                .background(isUser ? MyColor.main : MyColor.lightGray)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


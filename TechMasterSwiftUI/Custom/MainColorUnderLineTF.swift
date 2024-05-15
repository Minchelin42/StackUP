//
//  UnderLineTF.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct MainColorUnderLineTF: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(MyColor.main)
        }//VStack
    }//body
}


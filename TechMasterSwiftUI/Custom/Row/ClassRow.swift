//
//  ClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassRow: View {
    
    let item: ClassModel
    
    var body: some View {
        VStack(alignment: .trailing){
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 7, height: 130)
            
            VStack {
                Text(item.className).blackMediumFont(size: 13)
                    .multilineTextAlignment(.trailing)
                Spacer()
            }
            .frame(height: 40)

        }
    }
}


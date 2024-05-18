//
//  ReviewRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ReviewRow: View {
    
    let nickname: String
    let review: String
    
    var body: some View {
        HStack(alignment: .top) {
            MyImage.testImg
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(nickname).subtitleFont()
                    .padding(.bottom, 2)
                Text(review).blackMediumFont(size: 11).frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

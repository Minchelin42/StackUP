//
//  ReviewRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ReviewRow: View {
    var body: some View {
        HStack(alignment: .top) {
            MyImage.testImg
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text("Samdasu").subtitleFont()
                    .padding(.bottom, 2)
                Text("이거 해봤는데 진심 악마랑 거래한 수준으로 성장해요").blackMediumFont(size: 11).frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ReviewRow()
}

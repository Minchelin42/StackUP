//
//  MyReviewRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/19.
//

import SwiftUI

struct MyReviewRow: View {
    
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("3개월만에 실력이 확 늘어나는, 일러스트 강의").subtitleFont()
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(MyColor.main)
                }
            }
            Text("입문용 강의로 적당하다고 생각합니다!! 완전 강추 드려요\n입문용 강의로 적당하다고 생각합니다!! 완전 강추 드려요\n입문용 강의로 적당하다고 생각합니다!! 완전 강추 드려요\n입문용 강의로 적당하다고 생각합니다!! 완전 강추 드려요")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(MyColor.darkGray)
        }
        .padding(16)
    }
}

//#Preview {
//    MyReviewRow()
//}

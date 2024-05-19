//
//  MyPageView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/19.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section() {
                    HStack {
                        MyImage.testImg
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("samdasu").blackMediumFont(size: 15)
                            Text("프로필 수정").mainMediumFont(size: 13)
                        }
                        .padding(.leading, 8)
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                
                Section() {
                    Text("찜한 강의").blackMediumFont(size: 13)
                    Text("수강신청 내역").blackMediumFont(size: 13)
                    Text("고객센터").blackMediumFont(size: 13)
                }
                
                Section(header: Text("작성한 후기")) {
                    MyReviewRow(action: { print("reviewRow Tapped") })
                    MyReviewRow(action: { print("reviewRow Tapped") })
                    MyReviewRow(action: { print("reviewRow Tapped") })
                    MyReviewRow(action: { print("reviewRow Tapped") })
                }.listRowInsets(EdgeInsets.init(top: 4, leading: 8, bottom: 4, trailing: 4))

            }.listSectionSpacing(12)
        }
    }
}

#Preview {
    MyPageView()
}

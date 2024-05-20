//
//  MyPageView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/19.
//

import SwiftUI

enum MyPage: String, CaseIterable, Hashable {
    case scrap = "찜한 강의"
    case course = "수강신청 내역"
    case customerService = "고객센터"
}

struct MyPageView: View {
    var body: some View {
        NavigationView {
            List {
                Section() {
                    NavigationLink {
                        NavigationLazyView(ContentView())
                    } label: {
                        ProfileView(nick: "삼다수")
                    }
                }
                
                Section() {
                    ForEach(MyPage.allCases, id: \.self) { myPage in
                        NavigationLink {
                            destination(myPage)
                        } label: {
                            Text(myPage.rawValue).blackMediumFont(size: 13)
                        }
                    }
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

struct ProfileView: View {
    
    let nick: String
    
    var body: some View {
        HStack {
            MyImage.testImg
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(nick).blackMediumFont(size: 15)
                Text("프로필 수정").mainMediumFont(size: 13)
            }
            .padding(.leading, 8)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

extension MyPageView {
    @ViewBuilder
    private func destination(_ destination: MyPage) -> some View {
        switch destination {
        case .scrap:
            NavigationLazyView(MyClassListView())
        case .course:
            NavigationLazyView(MyClassListView())
        case .customerService:
            ContentView() //나중에 채팅 뷰로 연결
        }
    }
}


#Preview {
    MyPageView()
}

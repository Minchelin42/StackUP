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
    case logout = "로그아웃"
}

struct MyPageView: View {
    
    @StateObject private var router = Router()
    @StateObject private var viewModel = MyPageViewModel()
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @State var alertPresent = false
    
    var body: some View {
        NavigationStack(path: $router.route) {
            List {
                Section() {
                    if let profile = viewModel.output.profile {
                        ProfileView(nick: profile.nick).wrapToButton {
                            router.push(view: NextView.editProfileView(nick: viewModel.output.profile.nick, id: viewModel.output.profile.id, profileImg: viewModel.output.profile.profileImage))
                        }
                    }
                }
                
                Section() {
                    ForEach(MyPage.allCases, id: \.self) { myPage in
                        if myPage.rawValue != "로그아웃" {
                            Text(myPage.rawValue).blackMediumFont(size: 13).wrapToButton {
                                router.push(view: destination(myPage))
                            }
                        } else {
                            Text(myPage.rawValue).font(.system(size: 13, weight: .medium)).foregroundStyle(Color.red).wrapToButton {
                                self.alertPresent.toggle()
                            }.alert(isPresented: $alertPresent) {
                                Alert(title: Text("로그아웃 하시겠습니까?"), message: nil,
                                      primaryButton: .destructive(Text("확인"), action: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        withAnimation(.spring()) {
                                            appRootManager.currentRoot = .login
                                        }
                                        NowUser.isLogin = false
                                    }
                                }), secondaryButton: .cancel(Text("취소")))}
                        }
                    }
                }
                
                Section(header: Text("작성한 후기")) {
                    ForEach(viewModel.output.review, id: \.id) { review in
                        ScrollView {
                            MyReviewRow(title: review.classTitle, content: review.review) {
                                print("리뷰 클릭")
                            }.wrapToButton {
                                router.push(view: NextView.classDetailView(postID: review.classID))
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets.init(top: 4, leading: 8, bottom: 4, trailing: 4))
            }
            .task {
                viewModel.action(.loadMyProfileInfo)
            }
            .navigationDestination(for: NextView.self) { type in
                FeatureView(type: type)
                    .environmentObject(router)
            }
//            }.listSectionSpacing(12)
        }


    }
}

struct ProfileView: View {
    
    let nick: String
    
    var body: some View {
        HStack {
            MyImage.testImg.makeProfileImg(size: 70)
            
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
    private func destination(_ destination: MyPage) -> NextView {
        switch destination {
        case .scrap:
            NextView.scrapListView
        case .course:
            NextView.scrapListView
        case .customerService:
            NextView.chatView
        default: NextView.contentView
        }
    }
}


#Preview {
    MyPageView()
}

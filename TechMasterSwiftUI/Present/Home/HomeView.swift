//
//  HomeView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/22.
//

import SwiftUI

struct HomeView: View {
    
    private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.route) {
            ScrollView {
                VStack(alignment: .leading) {
                    NewClass(router: router, classList: viewModel.output.post)
                    Top7Class(router: router, classList: viewModel.output.post)
                    RecommandClass(router: router, classList: viewModel.output.post)
                }
            }
            .navigationDestination(for: NextView.self) { type in
                FeatureView(type: type)
                    .environmentObject(router)
            }
        }
        .task {
            viewModel.action(.loadClass)
        }
    }

}
extension HomeView {
    struct Top7Class: View {
        
        var router: Router
        var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
        var classList: ClassList
        
        var body: some View {
            Text("인기 강의 TOP 7").subtitleFont()
                .padding(.leading, 16)
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns) {
                    ForEach(Array(zip(classList.indices, classList)), id: \.0) { index, item in
                        ZStack {
                            BorderClassRow(categorySize: 10, titleSize: 12, height: 130, category: item.category, title: item.className).frame(width: 210, height: 175)
                            VStack() {
                                Text("\(index + 1)").font(.system(size: 40, weight: .black))
                                    .foregroundStyle(MyColor.black)
                                    .customStroke(color: MyColor.white, width: 1)
                                    .customStroke(color: MyColor.darkGray, width: 1)
                                    .padding(.leading, 8)
                                Spacer()
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }.wrapToButton {
                            print("클래스 클릭")
                            router.push(view: NextView.classDetailView(postID: item.post_id))
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 12)
        }
    }
    
    struct RecommandClass: View {
        
        var router: Router
        var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
        var classList: ClassList
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("이런 강의는 어때요?").subtitleFont()
                LazyVGrid(columns: columns) {
                    ForEach (classList, id: \.post_id) { item in
                        BorderClassRow(categorySize: 12, titleSize: 14, height: 190, category: item.category, title: item.className).wrapToButton {
                            router.push(view: NextView.classDetailView(postID: item.post_id))
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }
    }
    
    struct NewClass: View {
        
        var router: Router
        var rows: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
        var classList: ClassList
        
        var body: some View {
            Text("새로 나온 강의").subtitleFont().padding(.leading, 16)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach (classList, id: \.post_id) { item in
                        ClassRow(item: item.toDomain(), titleSize: 10).frame(maxWidth: 130).wrapToButton {
                            router.push(view: NextView.classDetailView(postID: item.post_id))
                        }
                    }
                }
                .frame(height: 180)
                .padding(.horizontal, 16)
            }
        }
    }
    
}

#Preview {
    HomeView()
}



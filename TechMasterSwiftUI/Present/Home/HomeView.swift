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

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    NewClass(classList: viewModel.output.post)
                    Top7Class(classList: viewModel.output.post)
                    RecommandClass(classList: viewModel.output.post)
                }
            }
        }
        .task {
            viewModel.action(.loadClass)
        }
    }

}

struct Top7Class: View {
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    var classList: ClassList
    
    var body: some View {
        Text("인기 강의 TOP 7").subtitleFont()
            .padding(.leading, 16)
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(Array(zip(classList.indices, classList)), id: \.0) { index, item in
                    NavigationLink {
                        NavigationLazyView(ClassDetailView(viewModel: ClassDetailViewModel(postID: item.post_id)))
                    } label: {
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
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 12)
    }
}

struct RecommandClass: View {
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    var classList: ClassList
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이런 강의는 어때요?").subtitleFont()
            LazyVGrid(columns: columns) {
                ForEach (classList, id: \.post_id) { item in
                    NavigationLink {
                        NavigationLazyView(ClassDetailView(viewModel: ClassDetailViewModel(postID: item.post_id)))
                    } label: {
                        BorderClassRow(categorySize: 12, titleSize: 14, height: 190, category: item.category, title: item.className)
                    }
                }
            }
        }.padding(.horizontal, 16)
    }
}

struct NewClass: View {
    
    var rows: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    var classList: ClassList
    
    var body: some View {
        Text("새로 나온 강의").subtitleFont().padding(.leading, 16)
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach (classList, id: \.post_id) { item in
                    NavigationLink {
                        NavigationLazyView(ClassDetailView(viewModel: ClassDetailViewModel(postID: item.post_id)))
                    } label: {
                        ClassRow(item: item, titleSize: 10).frame(maxWidth: 130)
                    }
                }
            }
            .frame(height: 180)
            .padding(.horizontal, 16)
        }
    }
}
    

#Preview {
    HomeView()
}



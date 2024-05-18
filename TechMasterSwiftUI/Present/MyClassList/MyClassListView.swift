//
//  MyClassListView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct MyClassListView: View {
    
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    @StateObject private var viewModel = MyClassListViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: colums) {
                    ForEach(viewModel.output.scrap, id: \.post_id) { item in
                        MyClassRow(item: item)
                    }
                }
            }
            .padding(.horizontal, 20)
            .task {
                viewModel.action(.getScrapList)
            }
        }
    }
}

#Preview {
    MyClassListView()
}

//
//  ClassListView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassListView: View {
    
    @StateObject var viewModel = ClassListViewModel()
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: colums) {
                    ForEach(viewModel.output.post, id: \.post_id) { item in
                        NavigationLink {
                            NavigationLazyView(ClassDetailView(viewModel: ClassDetailViewModel(postID: item.post_id)))
                        } label: {
                            ClassRow(item: item)
                        }
                        
                    }
                }
            }.padding(.horizontal, 20)
                .task {
                    viewModel.action(.viewOnAppear)
                }
        }
    }
}

#Preview {
    ClassListView()
}

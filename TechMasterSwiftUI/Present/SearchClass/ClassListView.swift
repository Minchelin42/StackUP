//
//  ClassListView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI 

struct ClassListView: View {
    
    @StateObject private var viewModel = ClassListViewModel()
    private var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(isSearching: $viewModel.output.isSearching, text: $viewModel.search, endEditingAction: {
                    viewModel.action(.searchClass)
                }, editingAction: {
                    viewModel.action(.removeOutput)
                }).padding(10)
                
                if viewModel.recommandVisiable() {
                    SearchRecommandView { word in
                        hideKeyboard()
                        viewModel.action(.searchRecommand(search: word))
                    }.padding(.leading, 12)
                } else {
                    LazyVGrid(columns: colums) {
                        ForEach(viewModel.output.post, id: \.post_id) { item in
                            NavigationLink {
                                NavigationLazyView(ClassDetailView(viewModel: ClassDetailViewModel(postID: item.post_id)))
                            } label: {
                                ClassRow(item: item.toDomain(), titleSize: 13)
                            }
                            
                        }
                    }
                }
            }.padding(.horizontal, 20)
        }
    }
}

private struct SearchBar: View {
    
    @Binding var isSearching: Bool
    let text: Binding<String>
    let endEditingAction: () -> Void
    let editingAction: () -> Void
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            Image(systemName: "magnifyingglass").foregroundStyle(MyColor.main)
            TextField("강의 카테고리로 검색", text: text) { isEnd in
                if !isEnd {
                    isSearching = true
                    endEditingAction()
                } else  {
                    isSearching = false
                    editingAction()
                }
            }.font(.system(size: 14, weight: .medium))
         
        }
        .frame(maxWidth: .infinity)
        .frame(height: 35)
        .background(MyColor.white)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .overlay(RoundedRectangle(cornerRadius: 7).stroke(MyColor.main, lineWidth: 1))
        .padding(.horizontal, 2)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    ClassListView()
}

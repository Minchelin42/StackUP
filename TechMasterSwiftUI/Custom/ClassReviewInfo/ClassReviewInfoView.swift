//
//  ClassReviewInfoView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import SwiftUI

struct ClassReviewInfoView: View {
    
    @StateObject var viewModel: ClassReviewInfoViewModel
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("강의후기").subtitleFont().padding(.bottom, 4)
            LazyVGrid(columns: colums) {
                ForEach(viewModel.output.review, id: \.post_id) { item in
                    ReviewRow(nickname: item.reviewer.nick, review: item.review)
                }
            }
        }.task {
            viewModel.action(.loadClassReview)
        }
    }
}

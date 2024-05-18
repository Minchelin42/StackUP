//
//  ClassDetailView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

@MainActor
struct ClassDetailView: View {

    @StateObject var viewModel = ClassDetailViewModel(postID: "")
    
    var body: some View {
        ScrollView {
            if let item = viewModel.output.post {
                VStack(alignment: .leading) {
                    MyImage.testImg
                        .resizable()
                        .asLoadImage(cornerRadius: 25, height: 230)
                        .padding(.bottom, 8)
                    ClassInfoView(buttonTitle: "수강하기", viewModel: ClassInfoViewModel(classInfo: viewModel.output.post))
                        .padding(.bottom, 4)
                    
                    classIntroductionView(intro: item.classIntro)
                    
                    ClassReviewInfoView(viewModel: ClassReviewInfoViewModel(postID: item.post_id))
                }
                .padding(.horizontal, 20)
            }//if let
        }//ScrollView
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    @ViewBuilder
    private func classIntroductionView(intro: String) -> some View {
        Text("강의소개")
            .subtitleFont()
            .padding(.bottom, 4)
        
        Text(intro)
            .blackMediumFont(size: 11)
            .padding(.bottom, 8)
        
        Rectangle()
            .foregroundColor(MyColor.lightGray)
            .frame(maxWidth: .infinity, maxHeight: 1)
            .padding(.bottom, 12)
    }
}

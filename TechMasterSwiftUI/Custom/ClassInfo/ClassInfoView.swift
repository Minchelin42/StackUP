//
//  ClassInfoView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

enum ButtonAction: String {
    case payment = "수강하기"
    case transition = "자세히 보기"
    case review = "수강 후기 작성"
}

struct ClassInfoView: View {

    let buttonAction: ButtonAction
    
    @StateObject var viewModel: ClassInfoViewModel
    
    var body: some View {
        
        HStack(alignment: .top) {
            ScrapButton(isScrap: $viewModel.nowStatus) {
                print("Scrap 했음")
                viewModel.action(.scrapButtonTapped(postID: viewModel.classInfo.post_id))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(viewModel.classInfo.className)").titleFont().multilineTextAlignment(.trailing)
                Text("무제한 수강 \(viewModel.classInfo.price)원").priceFont()
            }
        }
        
        MainColorButton(title: buttonAction.rawValue, action: {
            print("\(buttonAction.rawValue) 버튼 클릭")
            viewModel.action(.togglePresent)
        }, cornerRadius: 5, disabled: false).frame(height: 40)
        .padding(.bottom, 12)
        .navigationDestination(isPresented: $viewModel.isPresent) {
            destination(buttonAction)
        }
        
    }
}

extension ClassInfoView {
    @ViewBuilder
    private func destination(_ destination: ButtonAction) -> some View {
        switch destination {
        case .payment:
            ContentView() //임시 전환 뷰
        case .transition:
           ClassDetailView(viewModel: ClassDetailViewModel(postID: viewModel.classInfo.post_id))
        case .review:
            ContentView() //임시 전환 뷰
        }
    }
}


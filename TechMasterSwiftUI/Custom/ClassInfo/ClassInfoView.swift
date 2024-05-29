//
//  ClassInfoView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

enum ButtonType: String {
    case payment = "수강하기"
    case transition = "자세히 보기"
    case review = "수강 후기 작성"
}

struct ClassInfoView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ClassInfoViewModel
    var buttonAction: () -> Void
    
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
        
        MainColorButton(title: viewModel.buttonType.rawValue, cornerRadius: 5, disabled: false).frame(height: 40).wrapToButton {
            buttonAction()
        }
    }
}



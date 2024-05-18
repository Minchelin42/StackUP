//
//  ClassInfoView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassInfoView: View {

    let buttonTitle: String
    
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

        MainColorButton(title: buttonTitle, action: {
            print("\(buttonTitle) 버튼 클릭")
        }, cornerRadius: 5, disabled: false)
        .frame(height: 40)
        .padding(.bottom, 12)
    }
}


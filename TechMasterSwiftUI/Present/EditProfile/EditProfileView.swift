//
//  EditProfileView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @StateObject var viewModel: EditProfileViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer().frame(height: 90)
            
            MyImage.testImg.makeProfileImg(size: 120)
                .padding(.bottom, 30)
            
            profileInputView(option: "Nickname", text: $viewModel.nickname)
            profileInputView(option: "ID", text: $viewModel.id).disabled(true)
                .padding(.bottom, 70)
            
            MainColorButton(title: "프로필 수정", cornerRadius: 5, disabled: false).frame(height: 40)
                .wrapToButton {
                    viewModel.action(.editProfileButtonTapped)
                }
            
            Spacer()
        }
        .padding(.horizontal, 50)
    }
    
    private func profileInputView(option: String, text: Binding<String>) -> some View{
        VStack(alignment: .leading, spacing: 2) {
            Text(option).font(.system(size: 13, weight: .bold)).foregroundStyle(MyColor.lightGray)
            MainColorUnderLineTF(text: text, placeholder: "")
                .font(.system(size: 14, weight: .semibold))
        }
    }

}


//#Preview {
//    EditProfileView()
//}


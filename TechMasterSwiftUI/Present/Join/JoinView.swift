//
//  JoinView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI
import Combine

struct JoinView: View {
    
    @Environment(\.presentationMode) private var presentationMode //viewModel에 넣으면 안되나?
    @StateObject private var viewModel = JoinViewModel()
    var body: some View {
            VStack(alignment: .leading) {
                //아이디 입력 및 중복확인
                HStack(alignment: .bottom) {
                    MainColorUnderLineTF(text: $viewModel.id, placeholder: "ID")
                    MainColorButton(title: "중복확인", action: {
                        viewModel.action(.duplicateCheck)
                    }, cornerRadius: 10, disabled: !viewModel.output.duplicateCheck)
                    .frame(width: 80, height: 40)
                }
                Text(viewModel.output.idValid).mainMediumFont(size: 11).frame(height: 11)
                
                //비밀번호 입력
                MainColorUnderLineTF(text: $viewModel.password, placeholder: "Password")
                Text(viewModel.output.pwValid).mainMediumFont(size: 11).frame(height: 11)
                
                //닉네임 입력
                MainColorUnderLineTF(text: $viewModel.nickname, placeholder: "Nickname")
                Text(viewModel.output.nickValid).mainMediumFont(size: 11).frame(height: 11).padding(.bottom, 20)
                
                //회원가입 버튼
                MainColorButton(title: "회원가입", action: {
                    viewModel.action(.joinButtonTapped)
                }, cornerRadius: 10, disabled: !viewModel.output.joinAvailable)
                .frame(height: 40)
                .alert(isPresented: $viewModel.alertPresent) {
                    Alert(title: Text(viewModel.output.joinSuccess), message: Text(viewModel.output.alertMessage),
                          dismissButton: .default(Text("확인"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))}
            }
            .padding(.horizontal, 50)
            .task {
                
            }
        }
    
}

#Preview {
    JoinView()
}

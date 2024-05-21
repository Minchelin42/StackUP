//
//  LoginView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State var isPresent = false
    var body: some View {
        NavigationStack {
            VStack() {
                
                MainColorUnderLineTF(text: $viewModel.id, placeholder: "ID")
                    .padding(.bottom, 12)
                MainColorUnderLineTF(text: $viewModel.password, placeholder: "Password")
                    .padding(.bottom, 24)
                
                MainColorButton(title: "로그인", cornerRadius: 10, disabled: false).frame(height: 40)
                    .wrapToButton(action: {
                        viewModel.action(.loginButtonTapped)
                    })
                    .alert(isPresented: $viewModel.alertPresent) {
                        Alert(title: Text(viewModel.output.alertMessage), message: nil,
                              dismissButton: .default(Text("확인"), action: {
                            if viewModel.output.loginSuccess {
                                viewModel.classViewPresent = true
                            }
                        }))}
                
                MainColorBorderButton(title: "회원가입", action: {
                    print("회원가입")
                    isPresent.toggle()
                }, cornerRadius: 10).frame(height: 40)
                    .navigationDestination(isPresented: $isPresent) {
                        JoinView()
                    }
            }//VStack
            .padding(.horizontal, 50)
        }.fullScreenCover(isPresented: $viewModel.classViewPresent) {
            ClassListView()
        }         
    }
}

#Preview {
    LoginView()
}

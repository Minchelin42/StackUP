//
//  LoginView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @StateObject var router = Router()
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @State var isPresent = false
    
    var body: some View {
        NavigationStack(path: $router.route) {
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
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    withAnimation(.spring()) {
                                        appRootManager.currentRoot = .home
                                    }
                                    NowUser.isLogin = true
                                    viewModel.id.removeAll()
                                    viewModel.password.removeAll()
                                }
                            }
                        }))}
                
                
                MainColorBorderButton(title: "회원가입", action: {
                    print("회원가입 뷰로 이동")
                    isPresent.toggle()
                    router.push(view: NextView.joinView)
                    
                }, cornerRadius: 10).frame(height: 40)
                
            }//VStack
            .navigationDestination(for: NextView.self) { type in
                FeatureView(type: type)
            }
            .padding(.horizontal, 50)
        }
    }
}



#Preview {
    LoginView()
}

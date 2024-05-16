//
//  LoginView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct LoginView: View {
    
    @State private var id = ""
    @State private var password = ""

    
    
    var body: some View {
        VStack() {
            
            MainColorUnderLineTF(text: $id, placeholder: "ID")
                .padding(.bottom, 12)
            MainColorUnderLineTF(text: $password, placeholder: "Password")
                .padding(.bottom, 24)

            MainColorButton(title: "로그인", action: {
                print("ID:", id)
                print("Password:", password)
            }, cornerRadius: 10).frame(height: 40)

            MainColorBorderButton(title: "회원가입", action: {
                print("회원가입")
            }, cornerRadius: 10).frame(height: 40)
        }//VStack
        .padding(.horizontal, 50)
            
    }
}

#Preview {
    LoginView()
}

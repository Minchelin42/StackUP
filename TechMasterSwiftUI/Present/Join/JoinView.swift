//
//  JoinView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct JoinView: View {
    
    @State private var id = ""
    @State private var idValid = "아이디를 입력해주세요"
    @State private var password = ""
    @State private var passwordValid = "비밀번호를 입력해주세요"
    @State private var nickname = ""
    @State private var nicknameValid = "닉네임을 입력해주세요"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                MainColorUnderLineTF(text: $id, placeholder: "ID")
                MainColorButton(title: "중복확인", action: {
                    print("중복확인 클릭")
                }, cornerRadius: 10)
                .frame(width: 80, height: 40)
            }
            Text(idValid).mainMediumFont(size: 11)
            MainColorUnderLineTF(text: $password, placeholder: "Password")
            Text(passwordValid).mainMediumFont(size: 11)
            MainColorUnderLineTF(text: $nickname, placeholder: "Nickname")
            Text(nicknameValid).mainMediumFont(size: 11).padding(.bottom, 20)
            MainColorButton(title: "회원가입", action: {
                print("ID:", id)
                print("Password:", password)
                print("Nickname:",nickname)
            }, cornerRadius: 10).frame(height: 40)
            
        }//VStack
        .padding(.horizontal, 50)
            
    }
}

#Preview {
    JoinView()
}

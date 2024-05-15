//
//  ClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassRow: View {
    var body: some View {
        VStack(alignment: .trailing){
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 7, height: 130)
                .padding(.bottom, 4)
            
            Text("3개월만에 실력이 확 늘어나는,\n일러스트 강의").blackMediumFont(size: 13).multilineTextAlignment(.trailing)
                .padding(.bottom, 12)
        }
    }
}

#Preview {
    ClassRow()
}

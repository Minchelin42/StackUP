//
//  MyClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct MyClassRow: View {
    var body: some View {
        VStack{
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 0, height: 200)
                .padding(.bottom, 8)
            
            ClassInfoView(title: "3개월만에 실력이 확 늘어나는,\n일러스트 강의", price: "394,000", buttonTitle: "수강 후기 작성")
                .padding(.bottom, 4)
        }
    }
}

#Preview {
    MyClassRow()
}

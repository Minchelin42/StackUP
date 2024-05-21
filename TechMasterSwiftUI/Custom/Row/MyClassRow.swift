//
//  MyClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct MyClassRow: View {
    
    let item: ClassModel
    
    var body: some View {
        VStack{
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 0, height: 200)
                .padding(.bottom, 8)
            
            ClassInfoView(viewModel: ClassInfoViewModel(classInfo: item, buttonAction: .transition))
                .padding(.bottom, 4)
        }
    }
}

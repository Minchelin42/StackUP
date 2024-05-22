//
//  ClassRow.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassRow: View {
    
    let item: ClassModel
    let titleSize: CGFloat
    
    var body: some View {
        VStack(alignment: .trailing){
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 7, height: 130)
            
            VStack {
                Text(item.className).blackMediumFont(size: titleSize)
                    .multilineTextAlignment(.trailing)
                Spacer()
            }
            .frame(height: 40)

        }
    }
}


struct testClassRow: View {

    var body: some View {
        VStack(alignment: .leading){
            MyImage.testImg
                .resizable()
                .asLoadImage(cornerRadius: 7, height: 130)
            
            VStack {
                Text("3개월만에 실력이 확 늘어나는, 일러스트 강의").blackMediumFont(size: 12)
                   
                Spacer()
            }
            .frame(height: 40)

        }
    }
}


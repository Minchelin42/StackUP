//
//  ClassInfoView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassInfoView: View {
    
    let title: String
    let price: String
    
    let buttonTitle: String
    
    var body: some View {
        HStack(alignment: .top) {
            ScrapButton {
                print("Scrap 했음")
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(title)").titleFont()
                Text("무제한 수강 \(price)원").priceFont()
            }
        }
        
        
        MainColorButton(title: buttonTitle, action: {
            print("\(buttonTitle) 버튼 클릭")
        }, cornerRadius: 5)
        .frame(height: 40)
        .padding(.bottom, 12)
    }
}

#Preview {
    ClassInfoView(title: "DFSDF", price: "393,300", buttonTitle: "수강하기")
}

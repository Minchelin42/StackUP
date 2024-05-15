//
//  ClassDetailView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

struct ClassDetailView: View {

    var body: some View {
        ScrollView {
            VStack() {
                MyImage.testImg
                    .resizable()
                    .asLoadImage(cornerRadius: 25, height: 230)
                    .padding(.bottom, 8)
                
                ClassInfoView(title: "3개월만에 실력이 확 늘어나는,\n일러스트 강의", price: "394,000", buttonTitle: "수강하기")
                    .padding(.bottom, 4)
                
                ClassReviewInfoView(intro: "안녕하세요. 이모티콘도 그리고 만화도 그리고, 마음 내키는 대로 자유롭게 그리며 사는 작가 유랑입니다!\n 취미 삼아 2018년에 시작했던 이모티콘 제작은 어느새 4년이 넘게 이어지고 있어요. 저와는 떼려야 뗄 수 없는 존재가 되어버린 캐릭터들도 생겼고, 경제적으로도 삶이 풍요로워졌어요. 하지만 이 단계에 가기까지 저도 수많은 시행착오를 겪었답니다.\n이번 클래스 101 강의에서는 여러분에게 좀 더 쉽고 빠른 성공의 길을 안내해드리고 싶어요. 그리고 같은 길을 걷는 작가로서 함께 성장할 수 있기를 바라봅니다.")
            }
            .padding(.horizontal, 20)
        } 
    }
}


struct ClassReviewInfoView: View {
    
    let intro: String
    
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("강의소개").subtitleFont().padding(.bottom, 4)
            Text(intro).blackMediumFont(size: 11).padding(.bottom, 8)
            Rectangle().foregroundColor(MyColor.lightGray).frame(maxWidth: .infinity, maxHeight: 1).padding(.bottom, 12)
            
            Text("강의후기").subtitleFont().padding(.bottom, 4)

            LazyVGrid(columns: colums) {
                ForEach(0..<10) {_ in
                    ReviewRow()
                }
            }
        }
    }
}


#Preview {
    ClassDetailView()
}

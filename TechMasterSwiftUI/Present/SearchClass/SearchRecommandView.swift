//
//  SearchRecommandView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/23.
//

import SwiftUI

func SearchRecommandView(sendWord: @escaping (String) ->  Void) -> some View {
    
     var recommand = ["일러스트", "이모티콘", "뜨개질", "노션", "유튜브", "편집", "영어", "엑셀", "아이패드", "코딩"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("추천 검색어").subtitleFont()
            
            ForEach(recommand.indices) { index in
                HStack{
                    Text("\(index + 1)").mainMediumFont(size: 12)
                    Text("\(recommand[index])").blackMediumFont(size: 12)
                    
                    Spacer()
                }
                .wrapToButton {
                    sendWord(recommand[index])
                }
            }
        }
    }
    
    return body
}

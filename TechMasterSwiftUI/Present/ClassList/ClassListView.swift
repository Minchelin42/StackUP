//
//  ClassListView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ClassListView: View {
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(0..<10) { _ in
                    ClassRow()
                        .onTapGesture {
                            print("Class 선택")
                        }
                }
            }
        }.padding(.horizontal, 20)
    }
}

#Preview {
    ClassListView()
}

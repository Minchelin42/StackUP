//
//  MyClassListView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct MyClassListView: View {
    
    var colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(0..<10) {_ in
                    MyClassRow()
                }
            }
        }.padding(.horizontal, 20)
    }
}

#Preview {
    MyClassListView()
}

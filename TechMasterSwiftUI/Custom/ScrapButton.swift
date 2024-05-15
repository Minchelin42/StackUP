//
//  ScrapButton.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import SwiftUI

struct ScrapButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            MyImage.scrap
        }
        .frame(maxWidth: 24, maxHeight: 24)
    }
}

#Preview {
    ScrapButton(action: {print("scrap button clicked")})
}

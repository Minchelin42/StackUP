//
//  Font.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/14.
//

import SwiftUI

extension Text {
    func mainMediumFont(size: CGFloat) -> Text {
        self
            .font(.system(size: size))
            .fontWeight(.medium)
            .foregroundColor(MyColor.main)
    }
    
    func blackMediumFont(size: CGFloat) -> Text {
        self
            .font(.system(size: size))
            .fontWeight(.medium)
            .foregroundColor(MyColor.black)
    }
    
    func titleFont() -> Text {
        self
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .foregroundColor(MyColor.black)
    }
    
    func subtitleFont() -> Text {
        self
            .font(.system(size: 15))
            .fontWeight(.semibold)
            .foregroundColor(MyColor.black)
    }
    
    func priceFont() -> Text {
        self
            .font(.system(size: 17))
            .fontWeight(.semibold)
            .foregroundColor(MyColor.main)
    }
}

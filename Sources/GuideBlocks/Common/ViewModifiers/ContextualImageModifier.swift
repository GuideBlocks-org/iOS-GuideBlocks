//
//  ContextualImageModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/15.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualImageBackgroundModifier: ViewModifier {
    let backgroundColor: UIColor?
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor.map { Color($0) })
    }
}

struct ContextualImageResizeModifier: ViewModifier {
    
    let width: CGFloat?
    let height: CGFloat?
    
    func body(content: Content) -> some View {
        if let width, let height {
            content
                .frame(width: width, height: height)
        } else {
            content
                .frame(width: 40, height: 40)
        }
    }
}

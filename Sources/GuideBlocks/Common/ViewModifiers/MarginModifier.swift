//
//  MarginModifier.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/17.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct MarginModifier: ViewModifier {
    let margin: FourSide?
    
    func body(content: Content) -> some View {
        return content
            .padding(.top, margin?.top ?? 0)
            .padding(.bottom, margin?.bottom ?? 0)
            .padding(.leading, margin?.left ?? 0)
            .padding(.trailing, margin?.right ?? 0)
    }
}

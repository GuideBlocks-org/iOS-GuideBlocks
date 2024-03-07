//
//  ContextualBoxModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/15.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualBoxModifier: ViewModifier {
    let padding: FourSide?
    
    func body(content: Content) -> some View {
        if let padding {
            content
                .padding(EdgeInsets(
                    top: padding.top,
                    leading: padding.left,
                    bottom: padding.bottom,
                    trailing: padding.right
                ))
        } else {
            content
        }
    }
}

//
//  CloseButton.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/22.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct CloseButton: View {
    var padding = 10.0
    var foregroundColor = Color.white
    var backgroundColor = Color.red
    var imageElement: SHTipImageElement?
    var closeButtonTapped: () -> ()
    
    var body: some View {
        Button(
            action: {
                closeButtonTapped()
            },
            label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .contextualImageResize(imageElement)
                    .padding(padding)
                    .contextualImageBackground(imageElement)
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .clipShape(Circle())
                    .shadow(radius: 8)
                    .zIndex(11)
            }
        )
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(
            padding: 5,
            foregroundColor: .green,
            backgroundColor: .white,
            closeButtonTapped: {
            }
        )
    }
}

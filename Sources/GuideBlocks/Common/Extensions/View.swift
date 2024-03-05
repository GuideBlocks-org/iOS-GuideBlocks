//
//  View.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

extension View {
    func contextualContainerFormat(_ containerElement: SHTipElement?) -> some View {
        modifier(
            ContextualContainerModifier(
                width: containerElement?.width,
                widthUnit: containerElement?.widthUnit,
                height: containerElement?.height,
                heightUnit: containerElement?.heightUnit,
                padding: containerElement?.padding,
                backgroundColor: containerElement?.backgroundColor
            )
        )
    }
    
    func contextualTextFormat(_ textElement: SHTipTextElement?) -> some View {
        modifier(
            ContextualTextModifier(
                padding: textElement?.padding,
                fontName: textElement?.fontName,
                fontWeight: textElement?.fontWeight,
                fontSize: textElement?.fontSize,
                textColor: textElement?.textColor,
                backgroundColor: textElement?.backgroundColor
            )
        )
    }
    
    func contextualButtonFormat(_ buttonElement: SHTipButtonElement?) -> some View {
        modifier(
            ContextualButtonModifier(
                fontName: buttonElement?.fontName,
                fontWeight: buttonElement?.fontWeight,
                fontSize: buttonElement?.fontSize,
                textColor: buttonElement?.textColor,
                backgroundColor: buttonElement?.backgroundColor
            )
        )
    }
    
    func contextualImageBackground(_ imageElement: SHTipImageElement?) -> some View {
        modifier(
            ContextualImageBackgroundModifier(
                backgroundColor: imageElement?.backgroundColor
            )
        )
    }
    
    func contextualImageResize(_ imageElement: SHTipImageElement?) -> some View {
        modifier(
            ContextualImageResizeModifier(
                width: imageElement?.width,
                height: imageElement?.height
            )
        )
    }
    
    func contextualBoxFormat(_ boxElement: SHTipTextElement?) -> some View {
        modifier(
            ContextualBoxModifier(
                padding: boxElement?.padding
            )
        )
    }
    
    func contextualCarouselFormat(_ titleElement: SHTipCarouselItem?) -> some View {
        modifier(
            ContextualTextModifier(
                padding: nil,
                fontName: titleElement?.titleFontName,
                fontWeight: titleElement?.titleFontWeight,
                fontSize: titleElement?.titleFontSize,
                textColor: titleElement?.titleColor, 
                backgroundColor: titleElement?.backgroundColor
            )
        )
    }

    func contextualCarouselContentElement(_ contentElement: SHTipCarouselItem?) -> some View {
        modifier(
            ContextualTextModifier(
                padding: nil,
                fontName: contentElement?.contentFontName,
                fontWeight: contentElement?.contentFontWeight,
                fontSize: contentElement?.contentFontSize,
                textColor: contentElement?.contentColor,
                backgroundColor: contentElement?.backgroundColor
            )
        )
    }
    
    func margin(_ margin: FourSide?) -> some View {
        modifier(MarginModifier(margin: margin))
    }
}

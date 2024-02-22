//
//  SHTipButtonElement.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/16
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

extension SHTipButtonElement {
    
    var buttonTextAligment: Alignment {
        
        if self.alignment == .center {
            return .center
        } else if self.alignment == .left {
            return .leading
        } else if self.alignment == .right {
            return .trailing
        }
        return .center
    }
    
    var buttonSize: CGSize {
        
        return CGSize.sizeFromGuide(width: width, height: height)
    }
}
//
//  ContextualContainerModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/1.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualContainerModifier: ViewModifier {
    let width: CGFloat?
    let widthUnit: String?
    let height: CGFloat?
    let heightUnit: String?
    let padding: FourSide?
    let backgroundColor: UIColor?
    
    var frameWidth: CGFloat? {
        if let width, let widthUnit {
            return widthUnit == "PERCENTAGE" ? UIScreen.main.bounds.width * width : width
        }
        return nil
    }
    
    var frameHeight: CGFloat? {
        if let height, let heightUnit {
            return heightUnit == "PERCENTAGE" ? UIScreen.main.bounds.height * height : height
        }
        return nil
    }
    
    var edgeInsets: EdgeInsets? {
        if let padding {
            return EdgeInsets(
                top: padding.top,
                leading: padding.left,
                bottom: padding.bottom,
                trailing: padding.right
            )
        } else {
            return nil
        }
    }
    
    func body(content: Content) -> some View {
        if let width, width > 0 {
            if let edgeInsets {
                if let backgroundColor {
                    content
                        .frame(width: frameWidth, height: frameHeight)
                        .padding(edgeInsets)
                        .background(Color(backgroundColor))
                } else {
                    content
                        .frame(width: frameWidth, height: frameHeight)
                        .padding(edgeInsets)
                }
            } else {
                if let backgroundColor {
                    content
                        .frame(width: frameWidth, height: frameHeight)
                        .background(Color(backgroundColor))
                } else {
                    content
                        .frame(width: frameWidth, height: frameHeight)
                }
            }
        } else {
            if let edgeInsets {
                if let backgroundColor {
                    content
                        .padding(edgeInsets)
                        .background(Color(backgroundColor))
                } else {
                    content
                        .padding(edgeInsets)
                }
            } else {
                if let backgroundColor {
                    content
                        .background(Color(backgroundColor))
                } else {
                    content
                }
            }
        }
    }
}

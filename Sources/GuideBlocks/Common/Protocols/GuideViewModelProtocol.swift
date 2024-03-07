//
//  GuideViewModelProtocol.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/6.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

protocol GuideViewModelProtocol: ObservableObject {
    associatedtype GC: CTXBaseGuideController
    var guideController: GC? { get set }
    var guideIsVisible: Bool { get set }
    
    func dismiss(outside: Bool)
}

extension GuideViewModelProtocol {
    
    func dismiss(outside: Bool) {
        guideIsVisible = false
        if outside {
            guideController?.tapOutsideOfGuide()
        } else {
            guideController?.previousStepOfGuide()
        }
    }
}

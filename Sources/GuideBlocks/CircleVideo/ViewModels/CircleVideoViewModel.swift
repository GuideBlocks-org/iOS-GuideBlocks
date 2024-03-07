//
//  CircleVideoViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/21.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let circleVideoViewModel = CircleVideoViewModel()

class CircleVideoViewModel: GuideViewModelProtocol {
    var guideController: CircleVideoGuideController?
    
    var guideIsVisible = true
}

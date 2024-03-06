//
//  ConfettiViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/5.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let confettiViewModel = ConfettiViewModel()

class ConfettiViewModel : ObservableObject {
    var guideController: ConfettiGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }

    func acceptedGuide() {
        guideController?.nextStepOfGuide()
    }
}

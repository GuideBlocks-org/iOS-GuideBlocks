//
//  FancyAnnouncementViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/5
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let fancyAnnouncementViewModel = FancyAnnouncementViewModel()

class FancyAnnouncementViewModel: GuideViewModelProtocol {
    var guideController: FancyAnnouncementGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }
    var guideIsVisible = true
    
    func updateData() {
    }

}

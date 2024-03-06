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

class FancyAnnouncementViewModel : ObservableObject {
    var guideController: QRCodeGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }
    
    func updateData() {
    }

}

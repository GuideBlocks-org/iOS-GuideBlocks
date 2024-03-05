//
//  QRViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let qrViewModel = QRViewModel()

class QRViewModel : ObservableObject {
    var guideController: QRCodeGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }
    var scanButtonTapped: (() -> ())?
    var scannedCodeCallback: ((String) -> ())?
    
    @Published var isPopupVisible: Bool = false
    @Published var guideIsVisible = true
    
    func updateData() {
    }

}

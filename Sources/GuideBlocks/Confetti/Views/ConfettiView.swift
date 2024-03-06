//
//  ConfettiView.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/12/8.
//  Copyright © 2023 Yonas Stephen.
//

import SwiftUI
import ConfettiSwiftUI

struct ConfettiView: View {
    @State private var counter = 0
    
    var body: some View {
        Button("") {
        }
        .onAppear() {
            counter += 1
            confettiViewModel.acceptedGuide()
        }
        .confettiCannon(counter: $counter)
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView(
        )
    }
}

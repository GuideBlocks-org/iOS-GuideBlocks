//
//  BackDismissView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/4.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct BackDismissView: View {
    var viewTapped: () -> ()
    
    var body: some View {
        // background view to detect taps outside the button
        Color.white
            .onTapGesture {
                viewTapped()
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .edgesIgnoringSafeArea(.all)
            .opacity(0.1)
    }
}

struct BackDismissView_Previews: PreviewProvider {
    static var previews: some View {
        BackDismissView(
            viewTapped: {
            }
        )
    }
}

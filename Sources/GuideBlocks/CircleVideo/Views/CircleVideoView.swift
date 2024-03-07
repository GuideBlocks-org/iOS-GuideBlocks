//
//  CircleVideoView.swift
//  GuideBlocks
//
//  Created by David Jones on 2023/12/11.
//  Copyright © 2023 Contextual.
//

import ContextualSDK
import SwiftUI

// Round Popup View
struct CircleVideoView: View {
    var imageElement: SHTipImageElement?
    var videoUrl: String
    var circleDiameter: CGFloat
    var closeButtonTapped: () -> ()
    var videoIsPlaying: () -> ()
    
    var circlePadding: CGFloat {
        return 40.0 * (1.0 - circleDiameter / 300.0)
    }
    
    func dismiss(outside: Bool) {
        closeButtonTapped()
        circleVideoViewModel.dismiss(outside: outside)
    }
    
    var body: some View {
        ZStack {
            BackDismissView(
                viewTapped: {
                    dismiss(outside: true)
                }
            )
            VideoWebView(
                url: URL(string: videoUrl),
                videoIsPlaying: {
                    videoIsPlaying()
                }
            )
            .cornerRadius(circleDiameter/2)
            .frame(
                width: circleDiameter,
                height: circleDiameter
            )
            .padding(circlePadding)
            //.background(Color.yellow)
            .overlay(
                CloseButton(
                    imageElement: imageElement,
                    closeButtonTapped: {
                        dismiss(outside: false)
                    }
                ),
                alignment: .topTrailing
            )
        }
        .shadow(radius: circleDiameter/2)
    }
}

struct CircleVideoView_Previews: PreviewProvider {
    static var previews: some View {
        CircleVideoView(
            videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ?si=Wx9SC9sBIU6AlMnz",
            circleDiameter: 300,
            closeButtonTapped: {
            },
            videoIsPlaying: {
            }
        )
    }
}

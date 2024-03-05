//
//  CircleVideoGuideController.swift
//  GuideBlocks
//
//  Created by David Jones on 2023/12/11
//  Copyright © 2023 Contextual.
//

import SwiftUI
import ContextualSDK

/// A guide controller for displaying a circle video view.
public class CircleVideoGuideController: CTXBaseGuideController {
    public var videoIsPlaying: (() -> ())?
    public var closeButtonTapped: (() -> ())?
    
    private var hostingController: UIHostingController<CircleVideoView>?
    
    /// Presents the guide block.
    ///
    /// - Parameters:
    ///   - contextualContainer: The contextual container.
    ///   - controller: The view controller to present the guide block on.
    ///   - success: The closure to be called when the guide block is successfully presented.
    ///   - failure: The closure to be called when there is a failure in presenting the guide block.
    public override func presentGuideBlock(
        contextualContainer: ContextualContainer,
        viewController controller: UIViewController?,
        success: @escaping ((CTXIGuidePayload) -> ()),
        failure: @escaping ((CTXIGuidePayload) -> ())
    ) {
        guard let controller = controller else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        /* Example GuideBlock JSON for Dashboard
         {
           "guideBlockKey": "CircleVideo",
           "vid_url": "https://www.youtube.com/embed/Y9ChGCY8Azk?si=aLGas88lnxI6g_jJ?autoplay=1",
           "circle_diameter":200
         }
         */
        
        let guide = contextualContainer.guidePayload.guide
        let defaultVideoURL = "https://www.youtube.com/embed/Y9ChGCY8Azk?si=aLGas88lnxI6g_jJ?autoplay=1"
        let videoUrl = (guide.extraJson?["vid_url"] as? String) ?? defaultVideoURL
        let circleDiameter = (guide.extraJson?["circle_diameter"] as? CGFloat) ?? 200
        
        let view = CircleVideoView(
            imageElement: guide.arrayImages.first,
            videoUrl: videoUrl,
            circleDiameter: circleDiameter,
            closeButtonTapped: {
                self.dismissGuide()
                self.closeButtonTapped?()
            },
            videoIsPlaying: {
                self.tapInsideOfGuide()
                self.videoIsPlaying?()
            }
        )
        hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        controller.addChild(hostingController)
        controller.view.addSubview(hostingController.view)
        self.hostingController?.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ])
        
        hostingController.didMove(toParent: controller)

        success(contextualContainer.guidePayload)
    }
    
    /// Called when the app or framework dismisses the guide block, do cleanup to remove it.
    override public func isDismissingGuide() {
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()
    }
}

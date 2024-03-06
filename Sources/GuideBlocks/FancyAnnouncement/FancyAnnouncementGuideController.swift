//
//  FancyAnnouncementGuideController.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/11/7.
//  Copyright © 2023 Contextual.
//

import SwiftUI
import ContextualSDK

public class FancyAnnouncementGuideController: CTXBaseGuideController {
    public var closeButtonTapped: (() -> ())?
    public var leftButtonTapped: (() -> ())?
    public var rightButtonTapped: (() -> ())?
    
    private var hostingController: UIHostingController<FancyAnnouncementView>?
    
    public override func presentGuideBlock(
        contextualContainer: ContextualContainer,
        viewController controller: UIViewController?,
        success: @escaping ((CTXIGuidePayload) -> ()),
        failure: @escaping ((CTXIGuidePayload) -> ())
    ) {
        let guide = contextualContainer.guidePayload.guide
        
        guard let controller = controller else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        let dismissGuide = {
            self.dismissGuide()
        }
        fancyAnnouncementViewModel.guideController = self
        let view = FancyAnnouncementView(
            viewModel: fancyAnnouncementViewModel,
            imageUrl: guide.arrayImages?.first?.resource,
            closeButtonTapped: {
                dismissGuide()
                self.closeButtonTapped?()
            },
            leftButtonTapped: {
                self.previousStepOfGuide()
                self.leftButtonTapped?()
            },
            rightButtonTapped: {
                self.nextStepOfGuide()
                self.rightButtonTapped?()
            }
        )
        
        self.hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        controller.addChild(hostingController)
        controller.view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ])
        
        hostingController.didMove(toParent: controller)

        success(contextualContainer.guidePayload)
    }
    
    override public func isDismissingGuide() {
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()
    }
}

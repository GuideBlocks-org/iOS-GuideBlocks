//
//  SimpleTipGuideController.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/11/7.
//  Copyright © 2023 Contextual.
//

import SwiftUI
import ContextualSDK

public class SimpleTipGuideController: CTXBaseGuideController {
    var contextualContainer: ContextualContainer?
    
    public var closeButtonTapped: (() -> ())?
    public var leftButtonTapped: (() -> ())?
    public var rightButtonTapped: (() -> ())?
    
    private var hostingController: UIHostingController<SimpleTipView>?
    
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
        
        self.contextualContainer = contextualContainer
        
        let dismissGuide = {
            self.dismissGuide()
        }
        
        simpleTipViewModel.guideController = self
        
        let view = SimpleTipView(
            viewModel: simpleTipViewModel,
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

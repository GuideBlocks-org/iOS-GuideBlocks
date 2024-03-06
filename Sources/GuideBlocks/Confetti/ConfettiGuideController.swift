//
//  ConfettiGuideController.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/12/8.
//  Copyright © 2023 Contextual.
//

import SwiftUI
import ContextualSDK

public class ConfettiGuideController: CTXBaseGuideController {
    var contextualContainer: ContextualContainer?
    
    private var hostingController: UIHostingController<ConfettiView>?
    
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
        self.contextualContainer = contextualContainer
        confettiViewModel.guideController = self
        
        let view = ConfettiView()
        
        self.hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        controller.addChild(hostingController)
        controller.view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ])
        
        hostingController.didMove(toParent: controller)

        success(contextualContainer.guidePayload)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Invoking "nextStepOfGuide" after 5 seconds since it is a timed guide requiring no user intervention
            // - Invoking this method means that the SDK will try and present the next step in this guide (if there is one), OR;
            // - It will "accept" the guide (analytics event) if there is no step to proceed to and dismiss the guide
            // If we don't invoke this here, we would see a message in the console if we tried to use the same
            // guide again on a different page without this one being dismissed
            self.nextStepOfGuide()
        }
    }
    
    override public func isDismissingGuide() {
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()
    }
}

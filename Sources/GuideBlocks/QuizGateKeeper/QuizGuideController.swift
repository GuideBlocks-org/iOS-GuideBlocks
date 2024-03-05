//
//  QuizGuideController.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import ContextualSDK

/// A guide controller for displaying a checklist view.
public class QuizGuideController: CTXBaseGuideController {
    public var completedCallback: (() -> ())?
    public var closeButtonTapped: (() -> ())?
    
    var contextualContainer: ContextualContainer?
    private var hostingController: UIHostingController<QuizSheetView>?
    
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
        self.contextualContainer = contextualContainer
        quizViewModel.guideController = self
        quizViewModel.updateData()
        let view = QuizSheetView(
            viewModel: quizViewModel,
            closeButtonTapped: {
                self.dismissGuide()
                self.closeButtonTapped?()
            }
        )
        //view.buttonTextElement = guide.title
        self.hostingController = UIHostingController(rootView: view)
        
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

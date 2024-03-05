//
//  MultiSelectSurveyGuideController.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2024/1/25.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import ContextualSDK

public class MultiSelectSurveyGuideController: CTXBaseGuideController {
    
    private var hostingController: UIHostingController<SurveyView>?
    
    public override func presentGuideBlock(
        contextualContainer: ContextualContainer,
        viewController controller: UIViewController?,
        success: @escaping ((CTXIGuidePayload) -> ()),
        failure: @escaping ((CTXIGuidePayload) -> ())
    ) {
        let guide = contextualContainer.guidePayload.guide
        
        let title = guide.feedback?.feedbackTitle ?? ""
        let message = guide.feedback?.feedbackMessage ?? ""
        let options = guide.feedback?.arrayOptions as? [String] ?? []
        
        let question = MultipleChoiceQuestionModel(
            title: message,
            answers: options,
            multiSelect: true)
        
        let widgetView = SurveyView(
            title: title,
            question: question,
            cancelTapped: {
                self.hostingController?.dismiss(animated: true)
                self.previousStepOfGuide()
            },
            doneTapped: {
                let choices = question.choices.filter({ $0.selected }).map { $0.text }
                let feedback = CTXFeedback(title: message, answers: choices, extraJSON: [
                    "answers-array": choices,
                    "any-other-custom-data": "Example custom data"
                ])
                contextualContainer.operations.submitFeedback(
                    feedback,
                    forGuide: contextualContainer.guidePayload,
                    withHandler: { request, error in
                        if error != nil {
                            // Handler error here as necessary
                            return
                        }
                        // Handle success here as necessary, such as provide a modal to the user thanking them for their feedback
                    }
                )
                self.hostingController?.dismiss(animated: true)
                self.nextStepOfGuide()
            }
        )
        self.hostingController = UIHostingController(rootView: widgetView)
        controller?.present(self.hostingController!, animated: true)
        success(contextualContainer.guidePayload)
    }
    
    override public func isDismissingGuide() {
        // Ensure that if the SDK needs to remove the guide, that the guide is actually removed from the view hierarchy
        self.hostingController?.dismiss(animated: true)
    }
}

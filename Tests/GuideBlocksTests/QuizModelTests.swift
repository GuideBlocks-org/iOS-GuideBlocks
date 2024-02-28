//
//  QuizModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QuizModelTests: XCTestCase {
    
    func testRestartQuizAction() {
        var quizModel = QuizViewModel.sampleQuiz
        quizModel.correctCount = 1
        quizModel.performAction()
        XCTAssertEqual(quizModel.correctCount, 0)
    }
}
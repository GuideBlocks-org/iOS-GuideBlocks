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
    
    func testEncodingDecoding() throws {
        // Given
        let quizModel = QuizModel.sampleQuiz
        
        // When
        let encodedData = try JSONEncoder().encode(quizModel)
        let decodedModel = try JSONDecoder().decode(QuizModel.self, from: encodedData)
        
        // Then
        XCTAssertEqual(decodedModel.guideBlockKey, "QuizGateKeeper")
        XCTAssertEqual(decodedModel.questions.count, 2)
        XCTAssertEqual(decodedModel.fail.action, "restartQuiz")
        XCTAssertEqual(decodedModel.pass.action, "goHome")
    }
    
    func testSampleQuiz() {
        // Given & When
        let sampleQuiz = QuizModel.sampleQuiz
        
        // Then
        XCTAssertEqual(sampleQuiz.guideBlockKey, "QuizGateKeeper")
        XCTAssertEqual(sampleQuiz.questions.count, 2)
        XCTAssertEqual(sampleQuiz.fail.action, "restartQuiz")
        XCTAssertEqual(sampleQuiz.pass.action, "goHome")
    }
    
    func testQuizActionModel() {
        // Given
        var quizModel = QuizModel.sampleQuiz
        quizModel.correctCount = 1
        
        // When
        let quizActionModel = quizModel.quizActionModel
        
        // Then
        XCTAssertEqual(quizActionModel.actionType, .restartQuiz)
    }
    
    func testUpdateResultsData() {
        var quizModel = QuizModel.sampleQuiz
        quizModel.correctCount = 1
        XCTAssertEqual(quizModel.numberOfAttempts, 0)
        quizModel.updateResultsData()
        let quizAction = quizModel.quizActionModel
        XCTAssertEqual(quizModel.correctCount, 1)
        XCTAssertEqual(quizAction.action, "restartQuiz")
        XCTAssertEqual(quizModel.numberOfAttempts, 0)
    }
}

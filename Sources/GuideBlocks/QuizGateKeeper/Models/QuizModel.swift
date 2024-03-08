//
//  QuizModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

// Int is for number of seconds since 1970
enum LastTimeResult {
    case pass(Int)
    case fail(Int)
    case unknown
}

struct QuizModel: Codable {
    var contextualContainer: ContextualContainer?
    
    let guideBlockKey: String
    var questions: [QuestionModel]
    let fail: QuizActionModel
    let pass: QuizActionModel
    
    static let failTimeKey = "quiz_fail_time"
    static let passTimeKey = "quiz_pass_time"
    
    var correctCount = 0
    var numberOfAttempts = 0
    
    enum CodingKeys: String, CodingKey {
        case guideBlockKey
        case questions
        case fail
        case pass
    }
    
    static var sampleQuiz: QuizModel {
        return QuizModel(
            guideBlockKey: "QuizGateKeeper",
            questions: [QuestionModel.sampleQuestion1, QuestionModel.sampleQuestion2],
            fail: QuizActionModel(
                action: "restartQuiz",
                actionData: QuizActionData(
                    allowScreenAccess: false,
                    attempts: 2,
                    lockoutSeconds: 600
                )
            ),
            pass: QuizActionModel(
                action: "goHome",
                actionData: QuizActionData(
                    allowScreenAccess: true,
                    attempts: nil,
                    lockoutSeconds: nil
                )
            )
        )
    }
    
    var lastTimeResult: LastTimeResult {
        var failTime = 0
        var passTime = 0
        if let tagValue = contextualContainer?.tagManager.getTagValue(key: QuizModel.failTimeKey),
            let timeInterval = Int(tagValue) {
            failTime = timeInterval
        }
        if let tagValue = contextualContainer?.tagManager.getTagValue(key: QuizModel.passTimeKey),
            let timeInterval = Int(tagValue) {
            passTime = timeInterval
        }
        if passTime > failTime {
            return .pass(passTime)
        } else if failTime > passTime {
            return .fail(failTime)
        }
        return .unknown
    }
    
    var waitMinutesRemaining: Int {
        if waitSecondsRemaining % 60 > 0 {
            waitSecondsRemaining / 60 + 1
        } else {
            waitSecondsRemaining / 60
        }
    }
    
    var waitSecondsRemaining: Int {
        let actionData = quizActionModel.actionData
        switch lastTimeResult {
        case .pass(_):
            break
        case .fail(let failTime):
            if let lockoutSeconds = actionData.lockoutSeconds {
                return failTime + lockoutSeconds - Date.now
            }
        case .unknown:
            break
        }
        return 0
    }
    
    var shouldShowQuiz: Bool {
        let actionData = quizActionModel.actionData
        switch lastTimeResult {
        case .pass(_):
            return false
        case .fail(let failTime):
            if waitSecondsRemaining > 0 && actionData.allowScreenAccess {
                return false
            }
        case .unknown:
            return true
        }
        return true
    }
    
    var quizActionModel: QuizActionModel {
        correctCount < questions.count ? fail : pass
    }
    
    mutating func updateResultsData() {
        switch quizActionModel.actionType {
        case .restartQuiz:
            print("QuizModel, performAction, restartQuiz")
        case .goHome:
            print("QuizModel, performAction, goHome")
        }
        if correctCount == questions.count { // pass
            contextualContainer?.tagManager.saveTag(
                key: QuizModel.passTimeKey,
                value: Date.now,
                success: nil,
                failure: nil,
                forceSend: false
            )
        } else if let attempts = quizActionModel.actionData.attempts,
                  numberOfAttempts >= attempts { // failed
            contextualContainer?.tagManager.saveTag(
                key: QuizModel.failTimeKey,
                value: Date.now,
                success: nil,
                failure: nil,
                forceSend: false
            )
        }
    }
}


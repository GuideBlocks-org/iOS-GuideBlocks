//
//  QuizViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

public enum QuizFinalAction {
    case restartQuiz
    case blockAndWait
    case goHome
}

let quizViewModel = QuizViewModel()

class QuizViewModel: GuideViewModelProtocol {
    var guideController: QuizGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }
    
    @Published var guideIsVisible = false
    @Published var quizModel: QuizModel?
    @Published var currentQuestionIndex = 0
    @Published var actionButtonLabel = "OK"
    @Published var showResults = false {
        didSet {
            updateResultsData()
        }
    }
    
    var currentQuestion: QuestionModel? {
        quizModel?.questions[currentQuestionIndex]
    }
    
    var questionsCount: Int {
        quizModel?.questions.count ?? 0
    }

    var currentAnswers: [AnswerModel] {
        return currentQuestion?.answers ?? [AnswerModel]()
    }
    
    init() {
        loadWithSampleQuizs()
    }
    
    func loadWithSampleQuizs() {
        quizModel = QuizModel.sampleQuiz
        quizModel?.contextualContainer = contextualContainer
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        load(quizGuideJSON: guide?.extraJson)
        guideIsVisible = quizModel?.shouldShowQuiz ?? true
    }
    
    func load(quizGuideJSON: Any?) {
        if let quizGuideDictionary = quizGuideJSON as? NSDictionary,
           let quizGuideData = quizGuideDictionary.toData() {
            do {
                quizModel = try JSONDecoder().decode(QuizModel.self, from: quizGuideData)
                quizModel?.contextualContainer = contextualContainer
            } catch {
                print("couldn't serialize JSON, error: \(error)")
            }
        }
    }
    
    func choseAnswerWith(index: Int) {
        if currentQuestion?.answers[index].correct == true {
            quizModel?.correctCount += 1
        }
        if let quizModel, currentQuestionIndex < quizModel.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            quizModel?.numberOfAttempts += 1
            quizModel?.updateResultsData()
            showResults = true
        }
    }
    
    var quizFinalAction: QuizFinalAction {
        var result = QuizFinalAction.restartQuiz
        if let theQuizModel = quizModel {
            switch theQuizModel.quizActionModel.actionType {
            case .restartQuiz:
                result = .restartQuiz
            case .goHome:
                result = .goHome
            }
            let actionData = theQuizModel.quizActionModel.actionData
            if let attempts = actionData.attempts {
                if theQuizModel.numberOfAttempts >= attempts {
                    if theQuizModel.waitSecondsRemaining > 0 {
                        if actionData.allowScreenAccess {
                            result = .goHome
                        } else {
                            result = .blockAndWait
                        }
                    } else {
                        quizModel?.numberOfAttempts = 0
                        result = .restartQuiz
                    }
                }
            }
        }
        return result
    }
        
    func updateResultsData() {
        var result = "OK"
        switch quizFinalAction {
        case .restartQuiz:
            result = "Restart Quiz"
        case .blockAndWait:
            if let quizModel {
                let minutesRemaining = quizModel.waitMinutesRemaining
                result = "Wait for \(minutesRemaining) minutes"
                if minutesRemaining > 0 {
                    Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { [weak self] _ in
                        self?.updateResultsData()
                    }
                }
            }
        case .goHome:
            break
        }
        actionButtonLabel = result
    }
    
    func restartQuiz() {
        showResults = false
        currentQuestionIndex = 0
        quizModel?.correctCount = 0
    }
    
    func performAction() {
        switch quizFinalAction {
        case .restartQuiz:
            print("QuizViewModel, quizFinalAction, restartQuiz")
            restartQuiz()
        case .blockAndWait:
            print("QuizViewModel, quizFinalAction, blockAndWait")
            showResults = true
        case .goHome:
            print("QuizViewModel, quizFinalAction, goHome")
            guideIsVisible = false
            quizModel?.numberOfAttempts = 0
            guideController?.nextStepOfGuide()
            restartQuiz()
        }
    }
}

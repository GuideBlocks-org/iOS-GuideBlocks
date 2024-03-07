//
//  QuizViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

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
            showResults = true
        }
    }
    
    var performActionType: QuizActionType {
        guard let quizModel else {
            print("performActionType, quizModel is nil")
            return .goHome
        }
        var result = quizModel.quizActionModel.actionType
        if let attempts = quizModel.quizActionModel.actionData.attempts {
            if quizModel.numberOfAttempts >= attempts {
                result = .goHome
            }
        }
        return result
    }
        
    func updateResultsData() {
        var result = "OK"
        switch performActionType {
        case .restartQuiz:
            result = "Restart Quiz"
        case .goHome:
            break
        }
        actionButtonLabel = result
    }
    
    func performAction() {
        quizModel?.performAction()
        switch performActionType {
        case .restartQuiz:
            print("QuizViewModel, performAction, restartQuiz")
        case .goHome:
            print("QuizViewModel, performAction, goHome")
            guideIsVisible = false
            quizModel?.numberOfAttempts = 0
            guideController?.nextStepOfGuide()
        }
        showResults = false
        currentQuestionIndex = 0
        quizModel?.correctCount = 0
    }
}

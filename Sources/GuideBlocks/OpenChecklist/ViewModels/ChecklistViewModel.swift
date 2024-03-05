//
//  ChecklistViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let openChecklistViewModel = OpenChecklistViewModel()

class OpenChecklistViewModel : ObservableObject {
    var guideController: ChecklistGuideController?
    var contextualContainer: ContextualContainer? {
        guideController?.contextualContainer
    }
    
    @Published var isPopupVisible = false
    @Published var taskListVisible = true
    @Published var taskModels = [TaskModel]() {
        didSet {
            dismissIfNeeded()
        }
    }
    
    init() {
        loadWithSampleTasks()
    }
    
    func loadWithSampleTasks() {
        var result = [TaskModel]()
        for i in 1...12 {
            var taskModel = TaskModel.sampleTaskModelWith(index: i)
            taskModel.contextualContainer = contextualContainer
            result.append(taskModel)
        }
        taskModels = result
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        load(tasks: guide?.extraJson?["tasks"])
    }
    
    func load(tasks: Any?) {
        if let tasksArray = tasks as? NSArray, let tasksJson = tasksArray.toData() {
            if var loadedTaskModels = try? JSONDecoder().decode([TaskModel].self, from: tasksJson) {
                for (i, taskModel) in loadedTaskModels.enumerated() {
                    loadedTaskModels[i].contextualContainer = contextualContainer
                    loadedTaskModels[i].gotoScreenAction = { deepLinkURL in
                        print("gotoScreenAction for task: \(taskModel.name), deepLinkURL: \(deepLinkURL)")
                        if UIApplication.shared.canOpenURL(deepLinkURL) {
                            UIApplication.shared.open(deepLinkURL)
                        } else {
                            print("Cannot open deeplink")
                        }
                    }
                }
                taskModels = loadedTaskModels
            } else {
                print("couldn't JSON serialize data: \(tasksJson.hexEncodedString)")
            }
        }
    }
    
    func tappedATask() {
        guideController?.nextStepOfGuide()
    }
    
    func dismissIfNeeded() {
        var needToDismiss = true
        for taskModel in taskModels {
            if taskModel.enabled {
                needToDismiss = false
            }
        }
        taskListVisible = !needToDismiss
        if let guideController, needToDismiss {
            guideController.dismissGuide()
            guideController.completedCallback?()
        }
    }
    
}

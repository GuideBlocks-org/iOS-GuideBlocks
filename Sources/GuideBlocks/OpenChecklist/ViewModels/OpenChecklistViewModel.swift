//
//  OpenChecklistViewModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import Foundation
import SwiftUI

let openChecklistViewModel = OpenChecklistViewModel()

class OpenChecklistViewModel : ObservableObject {
    var contextualContainer: ContextualContainer?
    
    @Published var isPopupVisible: Bool = false
    @Published var title = "Do List"
    @Published var taskModels = [TaskModel]() {
        didSet {
            updateTaskListVisible()
        }
    }
    @Published var taskListVisible = true
    
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
    
    func updateTaskListVisible() {
        var result = false
        for taskModel in taskModels {
            if taskModel.enabled {
                result = true
            }
        }
        self.taskListVisible = result
    }
    
}
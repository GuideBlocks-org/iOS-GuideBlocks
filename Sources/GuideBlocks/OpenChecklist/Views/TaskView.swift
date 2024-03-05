//
//  TaskView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var viewModel: OpenChecklistViewModel
    var taskIndex: Int
    
    var taskModel: TaskModel {
        if taskIndex < viewModel.taskModels.count {
            return viewModel.taskModels[taskIndex]
        }
        return viewModel.taskModels.last ?? TaskModel.sampleTaskModelWith(index: 0)
    }
    
    var body: some View {
        Button(action: {
            if taskModel.enabled {
                print("Action for task \(taskModel.name)")
                viewModel.performAction(taskIndex)
            } else {
                print("Task \(taskModel.name) is not enabled")
            }
        }) {
            HStack {
                Text(taskModel.name)
                Spacer()
                Image(systemName: taskModel.checked ? "checkmark.square.fill" : "square.fill")
                    .foregroundColor(taskModel.checked ? .green : .gray)
            }
            .foregroundColor(taskModel.enabled ? .primary : .gray)
        }
        .disabled(!taskModel.enabled)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: openChecklistViewModel, taskIndex: 7)
    }
}

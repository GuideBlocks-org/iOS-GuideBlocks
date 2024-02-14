//
//  TaskView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var viewModel: OpenChecklistViewModel
    var taskIndex: Int
    
    var taskModel: TaskModel { viewModel.taskModels[taskIndex] }
    
    var body: some View {
        Button(action: {
            if taskModel.enabled {
                print("Action for task \(taskModel.name)")
                viewModel.taskModels[taskIndex].doTheAction()
                viewModel.isPopupVisible = false
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
        TaskView(viewModel: openChecklistViewModel, taskIndex: 0)
    }
}
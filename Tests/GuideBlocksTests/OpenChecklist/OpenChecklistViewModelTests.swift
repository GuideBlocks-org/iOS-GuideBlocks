//
//  OpenChecklistViewModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class OpenChecklistViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadWithSampleTasks() {
        openChecklistViewModel.loadWithSampleTasks()
        // Check if taskModels are loaded with sample tasks
        XCTAssertEqual(openChecklistViewModel.taskModels.count, 12)
        
        // Verify the properties of each taskModel
        for (index, taskModel) in openChecklistViewModel.taskModels.enumerated() {
            XCTAssertEqual(taskModel.name, "Task \(index + 1)")
            XCTAssertEqual(taskModel.checked, false)
            XCTAssertTrue(taskModel.enabled)
        }
    }
    
    func testUpdateData() {
        openChecklistViewModel.updateData()
        
        XCTAssertEqual(openChecklistViewModel.taskModels.count, 12)
    }
    
    func testLoadWithValidTasks() {
        let viewModel = OpenChecklistViewModel()
        let tasksArray: [Any] = [
            [
                "name": "Task 1",
                "action": "gotoScreen",
                "action_data": ["deep_link": "airbnbContextual://screen/task_1"]
            ],
            [
                "name": "Task 2",
                "action": "gotoScreen",
                "action_data": ["deep_link": "airbnbContextual://screen/task_2"]
            ]
        ]
        
        viewModel.load(tasks: tasksArray)
        
        XCTAssertEqual(viewModel.taskModels.count, 2)
        XCTAssertEqual(viewModel.taskModels[0].name, "Task 1")
        XCTAssertEqual(viewModel.taskModels[0].actionData.deepLink, "airbnbContextual://screen/task_1")
        XCTAssertEqual(viewModel.taskModels[1].name, "Task 2")
        XCTAssertEqual(viewModel.taskModels[1].actionData.deepLink, "airbnbContextual://screen/task_2")
    }
}

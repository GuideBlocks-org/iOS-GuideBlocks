//
//  TaskModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import XCTest

@testable import GuideBlocks

class TaskModelTests: XCTestCase {
    
    func testIDGeneration() {
        let task1 = TaskModel(
            name: "Task 1",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_3")
        )
        XCTAssertEqual(task1.id, "task_1")
        XCTAssertEqual(task2.id, "task_2")
        XCTAssertEqual(task3.id, "task_3")
    }
    
    func testEquality() {
        let task1 = TaskModel(
            name: "Task 1",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_3")
        )
        let task4 = TaskModel(
            name: "Task 3 ",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_3")
        )
        
        XCTAssertEqual(task1, task1) // A task is equal to itself
        XCTAssertNotEqual(task1, task2) // Different tasks should not be equal
        XCTAssertNotEqual(task1, task3) // Different tasks should not be equal
        
        XCTAssertEqual(task3, task4) // equal as they have same id
    }
    
    func testHashing() {
        let task1 = TaskModel(
            name: "Task 1",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_3")
        )
        let task4 = TaskModel(
            name: "Task 3 ",
            rawActionType: "gotoScreen",
            taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/screen_3")
        )
        
        XCTAssertEqual(task1.hashValue, task1.hashValue) // Hash value should be consistent
        XCTAssertNotEqual(task1.hashValue, task2.hashValue) // Different tasks should have different hash values
        XCTAssertNotEqual(task1.hashValue, task3.hashValue) // Different tasks should have different hash values
        XCTAssertEqual(task3.hashValue, task4.hashValue) // equal as they have same id
    }
}
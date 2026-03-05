//
//  TaskModels.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/3/26.
//

// This File is the logic of the application

import Foundation

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    
}

// Mock Data To Test App
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [TaskItem(title: "Grade Assisgnments"), TaskItem(title: "Prepare Lecture")]),
        TaskGroup(title: "Home", symbolName: "house.fill", tasks: [TaskItem(title: "Buy Groceries"), TaskItem(title: "Do Laundry")])]
}

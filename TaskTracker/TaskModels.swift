//
//  TaskModels.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/3/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
}

// Mock Data To Test App
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: String(localized: "school_group"), symbolName: "book.fill", tasks: [
            TaskItem(title: String(localized: "task_grade_assignments")),
            TaskItem(title: String(localized: "task_prepare_lecture"))
        ]),
        TaskGroup(title: String(localized: "home_group"), symbolName: "house.fill", tasks: [
            TaskItem(title: String(localized: "task_buy_groceries")),
            TaskItem(title: String(localized: "task_do_laundry"))
        ])
    ]
}

extension Profile {
    static let sample: [Profile] = [
        Profile(name: String(localized: "profile_professor"), profileImage: "professor_\(Locale.current.language.languageCode?.identifier ?? "en")", groups: TaskGroup.sampleData),
        Profile(name: String(localized: "profile_student"),   profileImage: "student_\(Locale.current.language.languageCode?.identifier ?? "en")",   groups: [])
    ]
}


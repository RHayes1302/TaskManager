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
    var nameKey: String          // store the key, not the translated string
    var profileImage: String
    var groups: [TaskGroup]

    var name: String {           // computed — always resolves in current language
        String(localized: String.LocalizationValue(nameKey))
    }
}

extension TaskGroup {
    static var sampleData: [TaskGroup] {
        [
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
}

extension Profile {
    static var sample: [Profile] {
        let lang = Locale.current.language.languageCode?.identifier ?? "en"
        return [
            Profile(nameKey: "profile_professor", profileImage: "professor_\(lang)", groups: TaskGroup.sampleData),
            Profile(nameKey: "profile_student",   profileImage: "student_\(lang)",   groups: [])
        ]
    }
}

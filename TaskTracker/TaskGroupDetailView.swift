//
//  TaskGroupDetailView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/3/26.
//

// Details That Are Shown On Right Screen Of The Ipad

//
//  TaskGroupDetailView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/3/26.
//

// Details That Are Shown On Right Screen Of The Ipad

import SwiftUI

struct TaskGroupDetailView: View {
    
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            Section {
                if sizeClass == .regular {
                    GroupStatsView(tasks: group.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
            ForEach($group.tasks) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .blue : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                        .accessibilityIdentifier("TaskCheckbox_\(task.id)")
                    
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                        .accessibilityIdentifier("TaskTextField_\(task.id)")
                }
            }
            .onDelete { index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    group.tasks.append(TaskItem(title: ""))
                }
            }
            .accessibilityIdentifier("AddTaskButton")
        }
    }
}

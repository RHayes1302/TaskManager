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
    // @State - same view
    // @Binding - parent view
    
    var body: some View {
        List {
            ForEach($group.tasks) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .blue : .gray)
                        .onTapGesture {
                            withAnimation{
                                task.isCompleted.toggle()
                            }
                        }
                    
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? . gray : .primary)
                    
                }
            }
            .onDelete{ index in
                group.tasks.remove(atOffsets: index)
            }
            
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation{
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
        
        
    }
}


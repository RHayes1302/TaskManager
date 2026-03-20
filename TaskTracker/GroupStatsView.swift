//
//  GroupStatsView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/5/26.
//

import SwiftUI

struct GroupStatsView: View {

    var tasks: [TaskItem]
    var completedCount: Int { tasks.filter { $0.isCompleted }.count }
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count) }
        
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(lineWidth: 10)
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .accessibilityIdentifier("ProgressPercentage")
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Task Progress")
                Text("\(completedCount) / \(tasks.count) Completed")
                    .accessibilityIdentifier("ProgressLabel")
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}

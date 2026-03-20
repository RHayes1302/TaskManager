//
//  NewGroupView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/5/26.
//

import SwiftUI

struct NewGroupView: View {
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    let icons = ["list.bullet", "bookmark.fill", "star", "house.fill", "folder", "heart"]
    
    @Environment(\.dismiss) var dismiss
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Group Name") {
                    TextField("Enter Group Name", text: $groupName)
                }
                
                Section("Select Icon") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(selectedIcon == icon ? Color.pink.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                                .accessibilityIdentifier("Icon_\(icon)")
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .accessibilityIdentifier("CancelGroupButton")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .accessibilityIdentifier("SaveGroupButton")
                }
            }
        }
    }
}

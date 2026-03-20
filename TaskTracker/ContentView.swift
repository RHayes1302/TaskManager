////
//  ContentView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup: Bool = false
    @State private var isDarkMode: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    let languageKey = "SavedLanguage"
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile

    var currentLanguage: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedGroup) {
                ForEach(profile.groups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                    .accessibilityIdentifier("GroupRow_\(group.id)")
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                }
                .accessibilityIdentifier("DarkModeToggle")

                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityIdentifier("AddGroupButton")
            }
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(group: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
                selectedGroup = newGroup
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("App is active")
            } else if newValue == .inactive {
                print("App is inactive")
            } else if newValue == .background {
                print("App is backgrounded")
                saveData()
            }
        }
    }

    func loadData() {
        let savedLanguage = UserDefaults.standard.string(forKey: languageKey)
        let languageChanged = savedLanguage != nil && savedLanguage != currentLanguage

        if !languageChanged, let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                profile.groups = decodedGroups
                return
            }
        }

        profile.groups = TaskGroup.sampleData
        saveData()
    }

    func saveData() {
        if let encodedGroups = try? JSONEncoder().encode(profile.groups) {
            UserDefaults.standard.set(encodedGroups, forKey: saveKey)
            UserDefaults.standard.set(currentLanguage, forKey: languageKey)
        }
    }
}

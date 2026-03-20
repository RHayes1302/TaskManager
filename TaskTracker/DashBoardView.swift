//
//  DashBoardView.swift
//  TaskTracker
//
//  Created by Ramone Hayes on 3/17/26.
//

import SwiftUI

struct DashBoardView: View {
    
    @State private var profile: [Profile] = []
    @State private var path = NavigationPath()
    let languageKey = "SavedDashboardLanguage"

    var currentLanguage: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack {
                        VStack(spacing: 10) {
                            Text("Welcome Back")
                                .font(.headline)
                                .textCase(.uppercase)
                            Text("Who is Working Today?")
                                .font(.subheadline)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach($profile) { $profile in
                                NavigationLink(value: profile) {
                                    VStack {
                                        if profile.profileImage.isEmpty {
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                        } else {
                                            Image(profile.profileImage)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                        }
                                        Text(profile.name)
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                    }
                                }
                                .accessibilityIdentifier("ProfileButton_\(profile.id)")
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Profile.self) { selectedProfile in
                if let index = profile.firstIndex(where: { $0.id == selectedProfile.id }) {
                    ContentView(profile: $profile[index])
                }
            }
        }
        .onAppear {
            loadProfiles()
        }
    }

    func loadProfiles() {
        let savedLanguage = UserDefaults.standard.string(forKey: languageKey)
        let languageChanged = savedLanguage != nil && savedLanguage != currentLanguage

        if languageChanged || profile.isEmpty {
            profile = Profile.sample
            UserDefaults.standard.set(currentLanguage, forKey: languageKey)
        }
    }
}

//
//  SettingsView.swift
//  LifeHack
//
//  Created by Afsal on 29/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var selectedThemeID: String? = Theme.default.id
    
    var body: some View {
        List(selection: $selectedThemeID) {
            Section("APP THEME") {
                ForEach(Theme.allThemes) { theme in
                    Row(theme: theme, isSelected: theme.id == selectedThemeID)
                        .listRowInsets(
                            .init(
                                top: 16.0,
                                leading: 16.0,
                                bottom: 16.0,
                                trailing: 16.0))
                        .listRowBackground(Color(uiColor: .systemBackground))
                }
            }
        }
    }
}

extension SettingsView {
    struct Row: View {
        let theme: Theme
        let isSelected: Bool
        
        var body: some View {
            LabeledContent {
                HStack {
                    Placeholder(imageName: "sun.max.fill")
                        .style(color: theme.accentColor)
                    Placeholder(imageName: "moon.fill")
                        .style(color: theme.secondaryColor)
                    Placeholder(imageName: "leaf")
                        .style(color: theme.secondaryColor, isFilled: false)
                }
            } label: {
                HStack {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundStyle(isSelected ? theme.accentColor : .secondary)
                    Text(theme.name)
                }
            }
            .font(.headline)
            .foregroundStyle(.primary)
        }
    }
}

extension SettingsView.Row {
    struct Placeholder: View {
        let imageName: String
        
        var body: some View {
            Image(systemName: imageName)
                .frame(width: 42.0, height: 42.0)
        }
    }
}

#Preview {
    SettingsView()
}

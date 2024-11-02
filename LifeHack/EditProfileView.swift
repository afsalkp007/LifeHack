//
//  EditProfileView.swift
//  LifeHack
//
//  Created by Afsal on 27/10/2024.
//

import SwiftUI

struct EditProfileView: View {
    @State var user: User
    
    var body: some View {
        VStack {
            Header(name: $user.name, profileImageURL: user.profileImageURL)
            AboutMe(text: Binding(
                    get: { user.aboutMe ?? "" },
                    set: { text in user.aboutMe = text }))
        }
        .padding(20)
        .animation(.default, value: user)
    }
}

extension EditProfileView {
    struct ErrorMessage: View {
        let text: String
        
        init(_ text: String) {
            self.text = text
        }
        
        var body: some View {
            Text(text)
                .font(.footnote)
                .bold()
                .foregroundStyle(.orange)
        }
    }
}

extension EditProfileView {
    struct AboutMe: View {
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("About me.")
                    .font(.callout)
                    .bold()
                TextEditor(text: $text)
                    .frame(height: 200.0)
                EditProfileView.ErrorMessage("The about me cannot be empty")
                    .visible(text.isEmpty)
            }
        }
    }
}

extension EditProfileView {
    struct Header: View {
        @Binding var name: String
        var profileImageURL: URL?
        
        var body: some View {
            HStack {
                AsyncImage(url: profileImageURL) { image in
                    image.circular(borderColor: .gray)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 62.0, height: 62.0)
                VStack(alignment: .leading) {
                    TextField("Name", text: $name)
                    Divider()
                    EditProfileView.ErrorMessage("The name cannot be empty")
                        .visible(name.isEmpty)
                }
                .padding(.leading, 16.0)
            }

        }
    }
}

extension View {
    func visible(_ isVisible: Bool) -> some View {
        opacity(isVisible ? 1.0 : 0.0)
    }
}

#Preview {
    EditProfileView(user: .preview)
}

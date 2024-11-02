//
//  QuestionView.swift
//  LifeHack
//
//  Created by Afsal on 25/10/2024.
//

import SwiftUI

struct QuestionView: View {
    @State var question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24.0) {
            HStack(alignment: .top, spacing: 16.0) {
                Voting(
                    score: question.score,
                    vote: .init(vote: question.vote),
                    upVote: { question.upvote() },
                    downVote: { question.downvote() },
                    unVote: { question.unvote() })
                Info(question: question)
            }
            QuestionBody(text: question.body)
            if let owner = question.owner {
                Owner(owner: owner)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal, 20.0)
    }
}

extension QuestionView.Owner {
    init(owner: User) {
        name = owner.name
        reputation = owner.reputation
        profileImageURL = owner.profileImageURL
    }
}

extension QuestionView.Info {
    init(question: Question) {
        title = question.title
        viewCount = question.viewCount
        date = question.creationDate
    }
}

// MARK: - Owner

extension QuestionView  {
    struct Owner: View {
        let name: String
        let reputation: Int
        let profileImageURL: URL?
        
        var body: some View {
            HStack {
                AsyncImage(url: profileImageURL) { image in
                    image
                        .circular()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 48.0, height: 48.0)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(name)
                        .font(.headline)
                    Text("\(reputation.formatted()) reputation")
                        .font(.caption)
                }
            }
            .padding(16)
            .style(color: .accentColor)
        }
    }
}

extension Image {
    func circular(borderColor: Color = .white) -> some View {
        self
            .resizable()
            .clipShape(.circle)
            .overlay(Circle()
                .stroke(borderColor, lineWidth: 2))
    }
}

// MARK: - QuestionView

extension QuestionView {
    struct QuestionBody: View {
        let text: String
        var body: some View {
            let markdown = try! AttributedString(
                markdown: text,
                options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
            Text(markdown)
                .font(.subheadline)
        }
    }
}

// MARK: - Info

extension QuestionView {
    struct Info: View {
        let title: String
        let viewCount: Int
        let date: Date
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.headline)
                Group {
                    Text(date: date)
                    Text(viewCount: viewCount)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("Accesibility") {
    QuestionView(question: .preview)
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.xxxLarge)
}

//#Preview("VoteButton", traits: .sizeThatFitsLayout) {
//    HStack(spacing: 16) {
//        QuestionView.Voting.VoteButton(type: .up, hightLighted: true) {}
//        QuestionView.Voting.VoteButton(type: .up, hightLighted: false) {}
//        QuestionView.Voting.VoteButton(type: .down, hightLighted: true) {}
//        QuestionView.Voting.VoteButton(type: .down, hightLighted: false) {}
//    }
//}
//
//#Preview("Image") {
//    Image("Avatar")
//        .circular(borderColor: .accent)
//        .frame(width: 200, height: 200)
//}
//

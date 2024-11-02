//
//  Voting.swift
//  LifeHack
//
//  Created by Afsal on 02/11/2024.
//

import SwiftUI

// MARK: - Voting

extension QuestionView {
    struct Voting: View {
        let score: Int
        var vote: Vote?
        let upVote: () -> Void
        let downVote: () -> Void
        let unVote: () -> Void
        
        enum Vote {
            case up, down
        }

        var body: some View {
            VStack(spacing: 8.0) {
                VoteButton(type: .up, hightLighted: vote == .up) {
                    cast(vote: .up)
                }
                Text("\(score)")
                    .font(.title)
                    .foregroundColor(.secondary)
                VoteButton(type: .down, hightLighted: vote == .down) {
                    cast(vote: .down)
                }
            }
        }
        
        private func cast(vote: Vote) {
            switch (self.vote, vote) {
            case (nil, .up), (.down, .up): upVote()
            case (nil, .down), (.up, .down): downVote()
            default: unVote()
            }
        }
    }
}

extension QuestionView.Voting.Vote {
    init?(vote: Vote?) {
        switch vote {
        case .up: self = .up
        case .down: self = .down
        case .none: return nil
        }
    }
}

// MARK: - VoteButton

extension QuestionView.Voting {
    struct VoteButton: View {
        let type: ButtonType
        let hightLighted: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                type.image(highLighted: hightLighted)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
    }
}

// MARK: - ButtonType

extension QuestionView.Voting.VoteButton {
    enum ButtonType: String {
        case up = "arrowtriangle.up"
        case down = "arrowtriangle.down"
        
        func image(highLighted: Bool) -> Image {
            Image(systemName: highLighted ? rawValue + ".fill" : rawValue)
        }
    }
}

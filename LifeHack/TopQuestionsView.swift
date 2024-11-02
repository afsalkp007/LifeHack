//
//  TopQuestionsView.swift
//  LifeHack
//
//  Created by Afsal on 28/10/2024.
//

import SwiftUI

struct TopQuestionsView: View {
    @State var questions: [Question]
    
    var body: some View {
        VStack {
            EditButton()
            List {
                ForEach(questions) { question in
                    Row(question: question)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: move)
            }
            .listStyle(.plain)
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }
    
    func move(offsets: IndexSet, to destination: Int) {
        questions.move(fromOffsets: offsets, toOffset: destination)
    }
}

extension TopQuestionsView {
    struct Row: View {
        let title: String
        let score: Int
        let answerCount: Int
        let viewCount: Int
        let date: Date
        let name: String
        let isAnswered: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                HStack(alignment: .center, spacing: 16) {
                    Counter(count: score, label: "votes")
                        .style(color: .accentColor)
                    Counter(count: score, label: "votes")
                        .style(color: .pizazz, isFilled: isAnswered)
                    Details(viewCount: viewCount, date: date, name: name)
                }
                .padding(.vertical, 8)
            }
        }
    }
}

extension TopQuestionsView.Row {
    init(question: Question) {
        self.init(
            title: question.title,
            score: question.score,
            answerCount: question.answerCount,
            viewCount: question.viewCount,
            date: question.creationDate,
            name: question.owner?.name ?? "",
            isAnswered: question.isAnswered
        )
    }
}

extension TopQuestionsView.Row {
    struct Details: View {
        let viewCount: Int
        let date: Date
        let name: String

        var body: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(viewCount: viewCount)
                Text(date: date)
                Text(name)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

extension Text {
    init(viewCount: Int) {
        self.init("View \(viewCount.formatted()) times")
    }
    
    init(date: Date, prefix: String = "Asked on") {
        self.init(prefix + " " + date.formatted(date: .long, time: .omitted))
    }
}

extension TopQuestionsView.Row {
    struct Counter: View {
        let count: Int
        let label: String
        
        var body: some View {
            VStack {
                Text("\(count)")
                    .font(.title3)
                    .bold()
                Text(label)
                    .font(.caption)
            }
            .frame(width: 67, height: 67)
        }
    }
}

#Preview {
    TopQuestionsView(questions: .preview)
}

#Preview("Rows") {
    Group {
        VStack {
            TopQuestionsView.Row(question: .preview)
            TopQuestionsView.Row(question: .unanswered)
        }
    }
}

//
//  DetailView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 04/02/2026.
//

import SwiftUI
import SwiftData
import ThemeKit

struct DetailView: View {
    @Environment(\.modelContext) private var context
    let scrum: DailyScrum

    @State private var isPresentingEditView: Bool = false
    @State private var errorWrapper: ErrorWrapper?

    let dateFormatter = Date.FormatStyle(date: .numeric, time: .shortened)
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: scrum, errorWrapper: $errorWrapper)) {
                    Label("Start Meeting", systemImage: "timer")
                        .accessibilityLabel("Start a new meeting button")
                        .font(.headline)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundStyle(Color(scrum.theme.accentColor))
                        .background(scrum.theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, format: dateFormatter)
                            Spacer()
                            if history.transcript != nil {
                                Image(systemName: "mic")
                            }
                        }
                    }
                }
                .onDelete { indices in
                    scrum.history.remove(atOffsets: indices)
                    try? context.save()
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button {
                isPresentingEditView = true
            } label: {
                Text("Edit")
            }

        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: scrum)
                    .navigationTitle(scrum.title)
            }
        }
        .sheet(item: $errorWrapper, onDismiss: nil) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }
}

#Preview(traits: .dailyScrumSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    NavigationStack {
        DetailView(scrum: scrums[0])
    }
}

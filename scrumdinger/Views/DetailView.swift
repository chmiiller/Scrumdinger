//
//  DetailView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 04/02/2026.
//

import SwiftUI
import ThemeKit

struct DetailView: View {
    @Binding var scrum: DailyScrum

    @State private var isPresentingEditView: Bool = false
    @State private var editingScrum: DailyScrum = DailyScrum.emptyScrum

    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
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
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button {
                isPresentingEditView = true
                editingScrum = scrum
            } label: {
                Text("Edit")
            }

        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum, savedEdits: { dailyScrum in
                    scrum = dailyScrum
                })
                .navigationTitle(scrum.title)
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[1]
    NavigationStack {
        DetailView(scrum: $scrum)
    }
}

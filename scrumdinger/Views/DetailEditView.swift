//
//  DetailEditView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 10/02/2026.
//

import SwiftUI
import SwiftData
import ThemeKit

struct DetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var attendeeName: String = ""
    @State private var attendees: [Attendee]
    @State private var lengthInMinutesAsDouble: Double
    @State private var title: String
    @State private var theme: Theme
    @State private var errorWrapper: ErrorWrapper?
    @State private var isConfirmingDelete: Bool = false
    @State private var transcriptEnabled: Bool
    let scrum: DailyScrum
    private let isCreatingScrum: Bool
    
    init(scrum: DailyScrum?) {
        let scrumToEdit: DailyScrum
        if let scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
            isCreatingScrum = true
        }
        
        self.scrum = scrumToEdit
        self.attendees = scrumToEdit.attendees
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
        self.title = scrumToEdit.title
        self.theme = scrumToEdit.theme
        self.transcriptEnabled = scrumToEdit.transcriptEnabled
    }
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $title)
                HStack {
                    Slider(value: $lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length") // VoiceOver accessibility
                    }
                    .accessibilityValue("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $theme)
                Toggle(isOn: $transcriptEnabled) {
                    Label("Transcription enabled", systemImage: "mic")
                }
            }
            Section(header: Text("Attendees")) {
                ForEach(attendees) { person in
                    Text(person.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $attendeeName)
                    Button {
                        withAnimation {
                            let attendee = Attendee(name: attendeeName)
                            attendees.append(attendee)
                            attendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
            if !isCreatingScrum {
                Section(header: Text("Danger Zone")) {
                    Button(role: .destructive) {
                        isConfirmingDelete = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Meeting")
                        }
                    }
                    .confirmationDialog("Are you sure you want to delete this meeting?",
                                        isPresented: $isConfirmingDelete,
                                        titleVisibility: .visible
                    ) {
                        Button("Delete", role: .destructive) { deleteMeeting() }
                        Button("Cancel") { }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    do {
                        try saveEdits()
                        dismiss()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Daily scrum was not recorded. Try again later.")
                    }
                }
            }
        }
    }

    private func saveEdits() throws {
        print("$transcriptEnabled: \(transcriptEnabled)")
        scrum.attendees = attendees
        scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
        scrum.title = title
        scrum.theme = theme
        scrum.transcriptEnabled = transcriptEnabled
        
        if isCreatingScrum {
            context.insert(scrum)
        }

        try context.save()
    }
    
    private func deleteMeeting() {
        context.delete(scrum)
        dismiss()
    }
}

#Preview(traits: .dailyScrumSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}

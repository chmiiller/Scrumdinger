//
//  HistoryView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 18/02/2026.
//

import SwiftUI

struct HistoryView: View {
    let history: History

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

#Preview {
    let history: History = History(attendees: [
        Attendee(name: "Carlos"),
        Attendee(name: "Daniela"),
        Attendee(name: "Cake"),
    ], transcript: "This is a transcript")
    HistoryView(history: history)
}

//
//  ScrumsView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 03/02/2026.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false

    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    isPresentingNewScrumView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NewScrumSheet(scrums: $scrums)
            }
        }
    }
}

#Preview {
    @Previewable @State var scrums = DailyScrum.sampleData
    ScrumsView(scrums: $scrums)
}

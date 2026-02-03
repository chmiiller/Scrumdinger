//
//  ScrumsView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 03/02/2026.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        List(scrums) { scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}

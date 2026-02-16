//
//  NewScrumSheet.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 16/02/2026.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum: DailyScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum) { dailyScrum in
                scrums.append(dailyScrum)
            }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}

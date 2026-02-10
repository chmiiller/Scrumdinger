//
//  scrumdingerApp.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 03/02/2026.
//

import SwiftUI

@main
struct scrumdingerApp: App {
    @State private var scrums: [DailyScrum] = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}

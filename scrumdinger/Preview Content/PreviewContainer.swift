//
//  PreviewContainer.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 16/02/2026.
//

import SwiftUI
import SwiftData

struct DailyScrumSampleData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: DailyScrum.self, configurations: .init(isStoredInMemoryOnly: true))
        DailyScrum.sampleData.forEach { container.mainContext.insert($0) }
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var dailyScrumSampleData: Self = .modifier(DailyScrumSampleData())
}

//
//  NewScrumSheet.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 16/02/2026.
//

import SwiftUI

struct NewScrumSheet: View {
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}

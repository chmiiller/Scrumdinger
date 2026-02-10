//
//  ThemeView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 10/02/2026.
//

import SwiftUI
import ThemeKit

struct ThemeView: View {
    let theme: Theme

    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundStyle(Color(theme.accentColor))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}

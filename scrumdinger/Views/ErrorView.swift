//
//  ErrorView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 18/02/2026.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.dismiss) private var dismiss
    let errorWrapper: ErrorWrapper

    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private enum SampleError: Error {
    case errorRequired
}

#Preview {
    let error = ErrorWrapper(error: SampleError.errorRequired, guidance: "You can ignore this error")
    ErrorView(errorWrapper: error)
}

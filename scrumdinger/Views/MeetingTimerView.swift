//
//  MeetingTimerView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 18/02/2026.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool
    
    private var currentSpeaker: String {
        speakers.first { !$0.isCompleted }?.name ?? "Someone"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, style: StrokeStyle(lineWidth: 14))
                    }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    let speakers = [ScrumTimer.Speaker(name: "Cake", isCompleted: true), ScrumTimer.Speaker(name: "Lola", isCompleted: false)]
    MeetingTimerView(speakers: speakers, theme: .yellow, isRecording: false)
}

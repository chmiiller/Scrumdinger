//
//  ContentView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 03/02/2026.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @State var scrumTimer: ScrumTimer = ScrumTimer()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers,
                                  skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundStyle(Color(scrum.theme.accentColor))
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes,
                             attendeeNames: scrum.attendees.map({ $0.name }))
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: $scrum)
}

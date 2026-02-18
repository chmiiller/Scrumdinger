//
//  ContentView.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 03/02/2026.
//

import SwiftUI
import SwiftData
import AVFoundation
import ThemeKit
import TimerKit

struct MeetingView: View {
    @Environment(\.modelContext) private var context
    @State var scrumTimer: ScrumTimer = ScrumTimer()
    let scrum: DailyScrum
    @Binding var errorWrapper: ErrorWrapper?
    
    private let player: AVPlayer = AVPlayer.dingPlayer()

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
            startScrum()
        }
        .onDisappear {
            do {
                try endScrum()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "Meeting time was not recorded. Try again later.")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes,
                         attendeeNames: scrum.attendees.map({ $0.name }))
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() throws {
        scrumTimer.stopScrum()
        let history = History(attendees: scrum.attendees)
        scrum.history.insert(history, at: 0)
        try context.save()
    }
}

#Preview {
    MeetingView(scrum: DailyScrum.sampleData[0], errorWrapper: .constant(nil))
}

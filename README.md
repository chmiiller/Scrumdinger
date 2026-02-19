# Scrumdinger - An iOS Scrum‑management app built with SwiftUI & SwiftData

https://github.com/user-attachments/assets/332ecc88-6494-4b7f-acaf-c8fb17dbec36

## Welcome

Hi there,
I’m an iOS engineer and this repo contains my take on the [Apple Developer’s App Dev Tutorial](https://developer.apple.com/tutorials/app-dev-training/getting-started-with-scrumdinger). The app is a fully functioning scrum management tool built with SwiftUI and SwiftData. I've also added some personal features that I've thought the app could benefit from

## Features

- Create and manage scrum meetings with your team.
- Each meeting is archived in a history log, and you can review past sessions at any time.
- During a running meeting the app can transcribe everything that’s said
- Transcriptions and meeting data are kept locally on the device using SwiftData.

## Motivation

Even though I work with Swift and SwiftUI every day, I wanted to follow Apple’s official tutorial to see how they recommend structuring a real world app.
It was a chance to refresh my skills, learn best practices around project layout, packages, SwiftUI, SwiftData persistence, transcription and error handling

## Beyond the tutorial

Besides what is covered in the tutorial, I've added some extra functionalities to the app that I feel are essential:

1. Added the "Transcription enabled" toggle - Adds the option for the team to not transcribe the meeting
2. Transcription icon - from the history list, it's possible to know if a meeting had transcription enabled or not
3. History date format - history items show the date and time when they happened
4. Delete Meeting - from the Edit screen it's possible to delete a meeting. With a confirmation dialog
5. Delete History - from the Details screen it's possible to delete a history entry

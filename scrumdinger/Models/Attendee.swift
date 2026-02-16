//
//  Attendee.swift
//  scrumdinger
//
//  Created by Carlos Zinato on 16/02/2026.
//

import Foundation
import SwiftData

@Model
class Attendee: Identifiable {
    var id: UUID
    var name: String
    var dailyScrum: DailyScrum?
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

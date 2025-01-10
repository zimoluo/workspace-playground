//
//  Note.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/9/25.
//

import Foundation
import SwiftData

@Model
class Note {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var dateCreated: Date

    init(title: String, content: String, dateCreated: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
    }
}

//
//  ClipboardHistoryItem.swift
//  clipty
//
//  Created by Áron Geosits on 13/07/2024.
//

import Foundation
import SwiftData

@Model
class ClipboardHistoryItem {
    var text: String
    var date: Date
    
    init(text: String) {
        self.text = text
        self.date = Date.now
    }
}

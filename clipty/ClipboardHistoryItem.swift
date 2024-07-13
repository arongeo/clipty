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
    var item: String
    var date: Date
    
    init(item: String) {
        self.item = item
        self.date = Date.now
    }
}

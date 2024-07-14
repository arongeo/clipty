//
//  ClipboardPoller.swift
//  clipty
//
//  Created by Áron Geosits on 13/07/2024.
//

import Foundation
import SwiftUI
import SwiftData

class ClipboardPoller : ObservableObject {
    var currClipboardCount: Int = 0
    @Published var currClipboardText: String = ""
    @Published var isClipboardEmpty: Bool = true
    
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        self.parseClipboard()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in self.tryUpdateClipboard()})
    }
    
    func parseClipboard() {
        self.currClipboardCount = NSPasteboard.general.changeCount
        
        self.currClipboardText = if let unwrappedClipboard = NSPasteboard.general.string(forType: .string) {
            unwrappedClipboard
        } else {
            ""
        }
        
        self.isClipboardEmpty = NSPasteboard.general.string(forType: .string) == nil
    }
    
    func tryUpdateClipboard() {
        if currClipboardCount != NSPasteboard.general.changeCount &&
            currClipboardText != NSPasteboard.general.string(forType: .string) {
            self.parseClipboard()
            
            self.context.insert(ClipboardHistoryItem(text: self.currClipboardText))
        }
    }
    
}

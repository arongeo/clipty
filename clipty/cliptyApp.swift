//
//  cliptyApp.swift
//  clipty
//
//  Created by Áron Geosits on 13/07/2024.
//

import SwiftUI
import SwiftData
import Foundation

@main
struct cliptyApp: App {
    @ObservedObject var clipboardHandler: ClipboardHandler
    
    var container: ModelContainer
    
    init() {
        do {
            self.container = try ModelContainer(for: ClipboardHistoryItem.self)
        } catch {
            fatalError("Couldn't create/use ModelContainer")
        }
        
        self.clipboardHandler = ClipboardHandler(context: self.container.mainContext)
    }

    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.accessory)
        
        MenuBarExtra() {
            ClipboardHistoryView(clipboardHandler: self.clipboardHandler)
                .modelContainer(self.container)
        } label: {
            let clipboardTrimmed = self.clipboardHandler.currClipboardText.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
            
            Text(10 < clipboardTrimmed.count || clipboardTrimmed.isEmpty ? "" : " " + clipboardTrimmed)
            Image(systemName: self.clipboardHandler.isClipboardEmpty ? "clipboard" : "clipboard.fill")
        }.menuBarExtraStyle(.window)
    }
}

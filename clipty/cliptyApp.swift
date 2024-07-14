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
    @ObservedObject var clipboardPoller: ClipboardPoller
    
    var container: ModelContainer
    
    init() {
        do {
            self.container = try ModelContainer(for: ClipboardHistoryItem.self)
        } catch {
            fatalError("Couldn't create/use ModelContainer")
        }
        
        self.clipboardPoller = ClipboardPoller(context: self.container.mainContext)
    }

    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.accessory)
        
        MenuBarExtra() {
            ClipboardHistoryView()
                .modelContainer(self.container)
        } label: {
            let clipboardTrimmed = self.clipboardPoller.currClipboardText.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
            
            Text(10 < clipboardTrimmed.count || clipboardTrimmed.isEmpty ? "" : " " + clipboardTrimmed)
            Image(systemName: self.clipboardPoller.isClipboardEmpty ? "clipboard" : "clipboard.fill")
        }.menuBarExtraStyle(.window)
    }
}

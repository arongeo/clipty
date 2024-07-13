//
//  cliptyApp.swift
//  clipty
//
//  Created by Áron Geosits on 13/07/2024.
//

import SwiftUI
import Foundation

@main
struct cliptyApp: App {
    @ObservedObject var clipboardPoller = ClipboardPoller()
    
    init() {
        self.clipboardPoller = ClipboardPoller()
    }

    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.accessory)
        
        MenuBarExtra() {
            ClipboardHistoryView()
        } label: {
            let clipboardTrimmed = self.clipboardPoller.currClipboardText.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
            
            Text(10 < clipboardTrimmed.count || clipboardTrimmed.isEmpty ? "" : " " + clipboardTrimmed)
            Image(systemName: self.clipboardPoller.isClipboardEmpty ? "clipboard" : "clipboard.fill")
        }
    }
}

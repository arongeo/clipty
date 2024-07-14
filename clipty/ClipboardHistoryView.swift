//
//  ClipboardHistoryView.swift
//  clipty
//
//  Created by Áron Geosits on 13/07/2024.
//

import SwiftUI
import SwiftData

struct ClipboardHistoryView: View {
    @Environment(\.modelContext) private var context
    @Query private var clipboardHistory: [ClipboardHistoryItem]
    
    var clipboardHandler: ClipboardHandler
    
    init(clipboardHandler: ClipboardHandler) {
        self.clipboardHandler = clipboardHandler
    }
    
    var body: some View {
        VStack {
            ForEach (self.clipboardHistory) { item in
                Button(item.text, action: {
                    self.clipboardHandler.copyToClipboard(str: item.text)
                })
            }
        }
        Button("Clear", action: {
            do {
                try context.delete(model: ClipboardHistoryItem.self)
            } catch {
                print("Couldn't clear DB")
            }
            
            NSPasteboard.general.clearContents()
        })
        }
}

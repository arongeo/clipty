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
    
    var body: some View {
        VStack {
            ForEach (self.clipboardHistory) { item in
                Button(item.text, action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(item.text, forType: .string)
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

//
//  ClipboardHistoryItemView.swift
//  clipty
//
//  Created by Áron Geosits on 02/08/2024.
//

import SwiftUI

struct ClipboardHistoryItemView: View {
    var text: String
    var clipboardHandler: ClipboardHandler
    
    init(text: String, clipboardHandler: ClipboardHandler) {
        self.text = text
        self.clipboardHandler = clipboardHandler
    }
    
    var body: some View {
        HStack {
            Text(self.text)
            
            VStack {
                Button(systemImage: "trash", action: {
                    self.clipboardHandler
                })
            }
        }
    }
}

//
//  ClipboardHandler.swift
//  clipty
//
//  Created by Áron Geosits on 14/07/2024.
//

import Foundation
import SwiftUI
import SwiftData

class ClipboardHandler : ObservableObject {
    var currClipboardCount: Int = 0
    @Published var currClipboardText: String = ""
    @Published var isClipboardEmpty: Bool = true
    
    var blacklistedBundleIDs: [String]
    
    var context: ModelContext
    
    init(context: ModelContext) {
        self.blacklistedBundleIDs = ["com.apple.systempreferences", "com.apple.keychainaccess"]
        self.context = context
        
        self.currClipboardCount = NSPasteboard.general.changeCount
        self.currClipboardText = ""
        self.isClipboardEmpty = NSPasteboard.general.string(forType: .string) == nil
        
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
            if let unwrappedApp = NSWorkspace.shared.frontmostApplication {
                if let unwrappedBundleID = unwrappedApp.bundleIdentifier {
                    if self.blacklistedBundleIDs.contains(unwrappedBundleID) {
                        // We don't proceed, because it's most likely something secret
                        
                        self.currClipboardText = ""
                        self.currClipboardCount = NSPasteboard.general.changeCount
                        self.isClipboardEmpty = false
                        
                        return
                    }
                } else {
                    print("No bundle ID?")
                }
            } else {
                print("I really don't know how this happened")
            }
            
            self.parseClipboard()
            
            if !self.isClipboardEmpty {
                self.context.insert(ClipboardHistoryItem(text: self.currClipboardText))
            }
        }
    }
    
    public func clearClipboard() {
        NSPasteboard.general.clearContents()
    }
    
    public func copyToClipboard(str: String) {
        self.clearClipboard()
        
        NSPasteboard.general.setString(str, forType: .string)
        self.currClipboardCount = NSPasteboard.general.changeCount
        self.currClipboardText = str
    }
}


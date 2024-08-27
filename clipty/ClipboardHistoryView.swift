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
    
    @ObservedObject var clipboardHandler: ClipboardHandler
    
    init(clipboardHandler: ClipboardHandler) {
        self.clipboardHandler = clipboardHandler
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Current clipboard:")
                        Text(self.clipboardHandler.currClipboardText)
                            .font(.title)
                        Text(self.clipboardHandler.currClipboardDateTime.formatted())
                    }.padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        self.clipboardHandler.clearClipboard()
                    }) {
                        Image(systemName: "clear")
                    }.clipShape(.circle).padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.9921568627450981, green: 0.7333333333333333, blue: 0.17254901960784313, opacity: 0.9))
                .clipShape(.rect(cornerRadius: 5.0))
                .padding(.horizontal)
                .padding(.top)
                    
                
                Spacer()
                
                NavigationStack {
                    List(clipboardHistory.reversed()) { item in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Button(item.text, action: {
                                    self.clipboardHandler.copyToClipboard(str: item.text)
                                }).font(.title2)
                                Text(item.date.formatted())
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            Button(action: {
                                context.delete(item)
                            }) {
                                Image(systemName: "trash")
                            }.clipShape(.circle)
                        }
                    }
                }.padding(.horizontal)
            }
            HStack {
                Button("Clear History", action: {
                    do {
                        try context.delete(model: ClipboardHistoryItem.self)
                    } catch {
                        print("Couldn't clear DB")
                    }
                }).padding(.bottom)
                
                Button("Exit", action: {
                    exit(0)
                }).padding(.bottom)
            }
        }
    }
}

//
//  GamieApp.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 03. 30..
//

import SwiftUI
import AppKit

@main
struct GamieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var statsWindow: NSWindow?
    let gameLoop = GameLoop()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear() {
                    gameLoop.start()
                }
                .onDisappear {
                    NSApp.terminate(nil)
                }
        }
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Show Debug Window") {
                    openStatsWindow()
                }
                .keyboardShortcut("D", modifiers: [.command, .shift])
            }
        }
    }
    
    func openStatsWindow() {
        if statsWindow == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 150),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered,
                defer: false
            )
            window.title = "Stats"
            window.contentView = NSHostingView(rootView: DebugView(stats: gameLoop.stats))
            window.isReleasedWhenClosed = false
            window.makeKeyAndOrderFront(nil)
            statsWindow = window
        } else {
            statsWindow?.makeKeyAndOrderFront(nil)
        }
    }
}

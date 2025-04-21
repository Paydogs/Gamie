//
//  GamieApp.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 03. 30..
//

import SwiftUI
import AppKit
import SpriteKit

@main
struct GamieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var statsWindow: NSWindow?
    let gameLoop: GameLoop
    let environment: Environment
    let renderer: Renderer
    private let scene = SKScene(size: .init(width: 800, height: 600))

    
    init() {
        self.renderer = SpriteKitRenderer(scene: scene)
        self.environment = Environment()
        self.gameLoop = GameLoop(environment: environment, renderer: renderer)
    }
    
    var body: some Scene {
        WindowGroup {
            SpriteKitRenderView(scene: scene)
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
            CommandGroup(after: .appInfo) {
                Button("Add entity") {
                    environment.addEntity(.init())
                }
                .keyboardShortcut("A", modifiers: [.command, .shift])
            }
            CommandGroup(after: .appInfo) {
                Button("Remove first entity") {
                    if let toRemove = environment.entityLibrary.values.first {
                        environment.removeEntity(id: toRemove.id)
                    }
                }
                .keyboardShortcut("R", modifiers: [.command, .shift])
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
            window.contentView = NSHostingView(rootView: DebugView(gameLoopStats: gameLoop.stats,
                                                                   environmentStats: environment.stats))
            window.isReleasedWhenClosed = false
            window.makeKeyAndOrderFront(nil)
            statsWindow = window
        } else {
            statsWindow?.makeKeyAndOrderFront(nil)
        }
    }
}

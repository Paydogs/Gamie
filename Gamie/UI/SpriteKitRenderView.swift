//
//  SpriteKitRenderView.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import SwiftUI
import SpriteKit

struct SpriteKitRenderView: NSViewRepresentable {
    let scene: SKScene
    
    func makeNSView(context: Context) -> some SKView {
        let skView = SKView()
        skView.presentScene(scene)
        skView.preferredFramesPerSecond = 120
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsDrawCount = true
        
        return skView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}

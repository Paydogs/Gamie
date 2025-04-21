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
        skView.ignoresSiblingOrder = true
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        return skView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}

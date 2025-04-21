//
//  Renderer.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import SpriteKit

protocol Renderer {
    /// Called once per frame, before drawing any entities
    func clear()
    
    /// Submit a sprite for drawing at a given position and z‑order
    func draw(sprite: SKTexture, at position: CGPoint, zPosition: CGFloat)
    
    /// Flush or present the frame (no‑op for SpriteKit)
    func present()
}

class SpriteKitRenderer: Renderer {
    private let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        scene.removeAllChildren()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .systemTeal
    }
    
    func clear() {
        // Optionally clear dynamic nodes, or use a dedicated container node
        scene.removeAllChildren()
    }
    
    func draw(sprite: SKTexture, at position: CGPoint, zPosition: CGFloat) {
        let node = SKSpriteNode(texture: sprite)
        node.position = position
        node.zPosition = zPosition
        scene.addChild(node)
    }
    
    func present() {
        // SpriteKit auto‑renders each frame
    }
}

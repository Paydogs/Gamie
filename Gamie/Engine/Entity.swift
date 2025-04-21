//
//  Entity.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation

class Entity: Updatable {
    let id: UUID
    var position: CGPoint = .zero
    var velocity: CGVector = .zero

    var renderDescriptor: RenderDescriptor {
        .init(spriteName: "TestSprite", position: position, zIndex: 1)
    }
    
    init(id: UUID = .init()) {
        self.id = id
    }
    
    func update(deltaTime: CFTimeInterval) {        
        // Randomly change direction every few frames
        if Int.random(in: 0..<100) == 0 {
            let angle = Double.random(in: 0..<(.pi * 2))
            let speed: CGFloat = 50  // points per second
            velocity = CGVector(dx: cos(angle) * speed, dy: sin(angle) * speed)
        }
        
        // Move in current direction
        position.x += velocity.dx * deltaTime
        position.y += velocity.dy * deltaTime
        
    }
}

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
    var renderDescriptor: RenderDescriptor {
        .init(spriteName: "TestSprite", position: position, zIndex: 1)
    }
    
    init(id: UUID = .init()) {
        self.id = id
    }
    
    func update(deltaTime: CFTimeInterval) {
        print("Updating entity \(id) with time: \(deltaTime)")
    }
}

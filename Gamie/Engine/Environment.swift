//
//  Environment.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation
import SwiftUI
import Collections

class Environment: NSObject, EntityHandler, Updatable {
    let stats = EnvironmentStats()
    private(set) var entityLibrary: OrderedDictionary<UUID, Entity> = .init()
    
    private var renderDescriptors: [RenderDescriptor] = []
    
    func collectRenderDescriptors() {
        renderDescriptors.removeAll(keepingCapacity: true)
        for entity in entityLibrary.values {
            renderDescriptors.append(entity.renderDescriptor)
        }
        
        renderDescriptors.sort { $0.zIndex < $1.zIndex }
    }
    
    var descriptors: [RenderDescriptor] {
        renderDescriptors
    }
    
    func addEntity(_ entity: Entity) {
        print("[Environment] adding entity: \(entity)")
        entityLibrary[entity.id] = entity
        stats.entityCount = entityLibrary.count
    }
    
    func removeEntity(id: UUID) {
        print("[Environment] removing entity: \(id)")
        entityLibrary.removeValue(forKey: id)
        stats.entityCount = entityLibrary.count
    }
    
    func update(deltaTime: CFTimeInterval) {
        for entity in entityLibrary.values {
            entity.update(deltaTime: deltaTime)
        }
    }
}

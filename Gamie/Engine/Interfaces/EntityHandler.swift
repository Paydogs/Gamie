//
//  EntityHandler.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation

protocol EntityHandler {
    func addEntity(_ entity: Entity)
    func removeEntity(id: UUID)
}

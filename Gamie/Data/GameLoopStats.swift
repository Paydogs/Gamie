//
//  GameLoopStats.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation
import SwiftUI

class GameLoopStats: NSObject, ObservableObject {
    @Published var fps: Int = 0
    @Published var ticksPerSecond: Int = 0
}

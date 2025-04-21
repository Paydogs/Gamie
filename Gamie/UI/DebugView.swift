//
//  DebugView.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import SwiftUI

struct DebugView: View {
    @ObservedObject var gameLoopStats: GameLoopStats
    @ObservedObject var environmentStats: EnvironmentStats
    
    init(gameLoopStats: GameLoopStats,
         environmentStats: EnvironmentStats) {
        self.gameLoopStats = gameLoopStats
        self.environmentStats = environmentStats
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fps: \(gameLoopStats.fps)")
            Text("Ticks: \(gameLoopStats.ticks)")
            Text("Ticks per second: \(gameLoopStats.ticksPerSecond)")
            Divider()
            Text("Entity count: \(environmentStats.entityCount)")
        }
        .padding()
        .frame(minWidth: 200, minHeight: 100)
    }
}

//
//  DebugView.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import SwiftUI

struct DebugView: View {
    @ObservedObject var stats: GameLoopStats
    
    init(stats: GameLoopStats) {
        self.stats = stats
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Fps: \(stats.fps)")
            Text("Ticks per second: \(stats.ticksPerSecond)")
        }
        .padding()
        .frame(minWidth: 200, minHeight: 100)
    }
}

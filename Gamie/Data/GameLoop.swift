//
//  GameLoop.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import AppKit
import SwiftUI
import QuartzCore
import CoreFoundation
import CoreVideo

import Foundation
import AppKit

class GameLoop: NSObject {    
    let stats = GameLoopStats()
    private var displayLink: CADisplayLink?
    private var lastTime: CFAbsoluteTime = 0
    private var accumulator: CFTimeInterval = 0
    private var tickCount: Int = 0

    
    private var frameCount: Int = 0
    private var tickDeltaCount: Int = 0
    private var lastFPSTime: CFTimeInterval = 0
    private var lastTickTime: CFTimeInterval = 0
    
    private let updateInterval: CFTimeInterval = Configuration.shared.getDouble(.ups, defaultValue: 2)
    let fixedTimeStep: CFTimeInterval = 1.0 / 60.0
    
    func start() {
        lastTime = CFAbsoluteTimeGetCurrent()
        lastFPSTime = lastTime
        lastTickTime = lastTime
        
        displayLink = NSScreen.main?.displayLink(target: self,
                                                 selector: #selector(frameUpdate))
        guard let link = displayLink else {
            print("Failed to create display link")
            return
        }
        link.add(to: .main, forMode: .common)
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func frameUpdate() {
        let now = CFAbsoluteTimeGetCurrent()
        let deltaTime = now - lastTime
        lastTime = now
        accumulator += deltaTime
        
        // — FPS counter (updated every 0.5s) —
        frameCount += 1
        if now - lastFPSTime >= updateInterval {
            print("Tick")
            let fpsValue = Int(Double(frameCount) / (now - lastFPSTime))
            print("fpsValue: \(fpsValue)")
            DispatchQueue.main.async { [stats] in stats.fps = fpsValue }
            frameCount = 0
            lastFPSTime = now
        }
        
        // — Fixed‑timestep ticks —
        while accumulator >= fixedTimeStep {
            accumulator -= fixedTimeStep
            tickCount += 1
            tickDeltaCount += 1
        }
        
        // — TPS counter (updated every 0.5s) —
        if now - lastTickTime >= updateInterval {
            print("Tock")
            let tpsValue = Int(Double(tickDeltaCount) / (now - lastTickTime))
            print("tpsValue: \(tpsValue)")
            DispatchQueue.main.async { [stats] in stats.ticksPerSecond = tpsValue }
            tickDeltaCount = 0
            lastTickTime = now
        }
    }
}

private extension GameLoop {
    static func loadFixedTimeStep() -> CFTimeInterval {
        return 1.0 / Configuration.shared.getDouble(.lps, defaultValue: 1)
    }
}

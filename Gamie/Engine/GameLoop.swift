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
    
    let environment: Environment
    let renderer: Renderer
    
    private var displayLink: CADisplayLink?
    private var lastTime: CFAbsoluteTime = 0
    private var accumulator: CFTimeInterval = 0
    
    private var frameCount: Int = 0
    private var tickCount: UInt64 = 0
    private var tickDeltaCount: UInt64 = 0
    private var lastFPSTime: CFTimeInterval = 0
    private var lastTickTime: CFTimeInterval = 0
    
    private let updateInterval: CFTimeInterval = Configuration.shared.getDouble(.ups, defaultValue: 2)
    private let fixedTimeStep: CFTimeInterval = 1.0 / Configuration.shared.getDouble(.lps, defaultValue: 1)
    
    init(environment: Environment,
         renderer: Renderer) {
        self.environment = environment
        self.renderer = renderer
    }
    
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
        
        frameCount += 1
        if now - lastFPSTime >= updateInterval {
            let fpsValue = Int(Double(frameCount) / (now - lastFPSTime))
            DispatchQueue.main.async { [stats] in stats.fps = fpsValue }
            frameCount = 0
            lastFPSTime = now
        }
        
        // — Fixed‑timestep ticks —
        while accumulator >= fixedTimeStep {
            accumulator -= fixedTimeStep
            tickCount &+= 1
            tickDeltaCount &+= 1
            environment.update(deltaTime: fixedTimeStep)
        }
        
        if now - lastTickTime >= updateInterval {
            let tpsValue = Int(Double(tickDeltaCount) / (now - lastTickTime))
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    NSApp.terminate(nil)
                    return
                }
                stats.ticksPerSecond = tpsValue
                stats.ticks = tickCount
            }
            tickDeltaCount = 0
            lastTickTime = now
        }
    }
}

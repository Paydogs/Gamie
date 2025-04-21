//
//  EnvironmentStats.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation
import SwiftUI

class EnvironmentStats: NSObject, ObservableObject {
    @Published var entityCount: Int = 0
}

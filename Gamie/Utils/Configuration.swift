//
//  Configuration.swift
//  Gamie
//
//  Created by Andras Olah on 2025. 04. 21..
//

import Foundation

enum ConfigError: Error {
    case missingPlist
}

enum ConfigKey: String {
    case lps
    case ups
}

class Configuration {
    static let shared = Configuration()
    private let plist: [String: Any]
    
    init() {
        do {
            guard
                let url = Bundle.main.url(forResource: "Configuration", withExtension: "plist"),
                let data = try? Data(contentsOf: url),
                let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any]
            else {
                throw ConfigError.missingPlist
            }
            self.plist = plist
        } catch {
            self.plist = [:]
        }
    }
}

extension Configuration {
    func getDouble(_ key: ConfigKey, defaultValue: Double) -> Double {
        return plist[key.rawValue] as? Double ?? defaultValue
    }
}

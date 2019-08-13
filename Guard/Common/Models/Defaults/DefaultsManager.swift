//
//  DefaultsManager.swift
//  Guard
//
//  Created by Denys on 7/4/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

final class DefaultsManager {
    
    // MARK: - Keys
    enum Keys: String {
        case deleteMediaRuleKey
    }
    
    // MARK: - Properties
    static let shared = DefaultsManager()
    
    static var isPremium: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPremium")
        } set {
            UserDefaults.standard.set(newValue, forKey: "isPremium")
        }
    }
    
    var deleteMediaRule: DeleteMediaRule {
        get {
            let raw = UserDefaults.standard.integer(forKey: Keys.deleteMediaRuleKey.rawValue)
            return DeleteMediaRule(rawValue: raw) ?? .all
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.deleteMediaRuleKey.rawValue)
        }
    }
}

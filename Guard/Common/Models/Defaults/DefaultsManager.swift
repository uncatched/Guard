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
        case removeDuplicates
    }
    
    // MARK: - Properties
    static let shared = DefaultsManager()
    
    var deleteMediaRule: DeleteMediaRule {
        get {
            let raw = UserDefaults.standard.integer(forKey: Keys.deleteMediaRuleKey.rawValue)
            return DeleteMediaRule(rawValue: raw) ?? .all
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.deleteMediaRuleKey.rawValue)
        }
    }
    
    var removeDuplicates: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.removeDuplicates.rawValue)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.removeDuplicates.rawValue)
        }
    }
}

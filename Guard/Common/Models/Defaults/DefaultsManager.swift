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
        case isPremium
        case isPremiumShown
        case isSecondLaunch
    }
    
    // MARK: - Properties
    static let shared = DefaultsManager()
    
    static var isPremium: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isPremium.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.isPremium.rawValue)
        }
    }
    
    static var isPremiumShown: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isPremiumShown.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.isPremiumShown.rawValue)
        }
    }
    
    static var isSecondLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isSecondLaunch.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.isSecondLaunch.rawValue)
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

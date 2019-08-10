//
//  UserDefaultable.swift
//  MyApp
//
//  Created by X on 4/29/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

// MARK: - Key Namespaceable
protocol KeyNamespaceable { }

extension KeyNamespaceable {
    private static func namespace(_ key: String) -> String {
        return "\(Self.self).\(key)"
    }
    
    static func namespace<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
        return namespace(key.rawValue)
    }
}


// MARK: - Bool Defaults
protocol UserDefaultable : KeyNamespaceable {
    associatedtype DefaultableKey : RawRepresentable
}

extension UserDefaultable where DefaultableKey.RawValue == String {
    
    // ---- SET
    static func set(_ value: Any, forKey key: DefaultableKey) {
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // DELETE
    
    static func delete(forKey key: DefaultableKey) {
        let key = namespace(key)
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    // ---- GET
    static func string(forKey key: DefaultableKey, default value:String="") -> String {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key) ?? value
    }
    
    static func bool(forKey key: DefaultableKey) -> Bool {
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
    
    
    static func float(forKey key: DefaultableKey) -> Float {
        let key = namespace(key)
        return UserDefaults.standard.float(forKey: key)
    }
    
    
    static func integer(forKey key: DefaultableKey) -> Int {
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
    
    
    
    static func object(forKey key: DefaultableKey) -> Any? {
        let key = namespace(key)
        return UserDefaults.standard.object(forKey: key)
    }
    
    
    static func double(forKey key: DefaultableKey) -> Double {
        let key = namespace(key)
        return UserDefaults.standard.double(forKey: key)
    }
    
    static func url(forKey key: DefaultableKey) -> URL? {
        let key = namespace(key)
        return UserDefaults.standard.url(forKey: key)
    }
}

/*
// MARK: - Use
// Preparation
extension UserDefaults {
    struct Account : UserDefaultable {
        private init() { }
        
        enum BoolDefaultKey : String {
            case isUserLoggedIn
        }
    }
}

// Set
UserDefaults.Account.set(true, forKey: .isUserLoggedIn)

// Get
let isUserLoggedIn = UserDefaults.Account.bool(forKey: .isUserLoggedIn)
 */

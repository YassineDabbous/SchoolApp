//
//  UserDefaults.swift
//  Ekhdemni
//
//  Created by yassine dabbous on 3/18/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    struct Configs : UserDefaultable {
        private init() { }
        
        enum DefaultableKey : String {
            case isOnboardingShowed
        }
        
        static func onboarding(_ value:Bool){
            UserDefaults.Configs.set(value, forKey: .isOnboardingShowed)
        }
        static func onboarding() -> Bool{
            let v = UserDefaults.Configs.bool(forKey: .isOnboardingShowed)
            return v
        }
    }
    
    
    struct Account : UserDefaultable {
        private init() { }
        
        enum DefaultableKey : String {
            case isUserLoggedIn
            case email_hint
            case auth
        }
        
        static func auth(_ value:AuthResponse?){
            if let value = value {
                let coder = JSONEncoder()
                if let v = try? coder.encode(value) {
                    UserDefaults.Account.set(v, forKey: .auth)
                }
            } else {
                UserDefaults.Account.delete(forKey: .auth)
            }
        }
        static func auth() -> AuthResponse?{
            let coder = JSONDecoder()
            let dt = UserDefaults.Account.object(forKey: .auth)
            guard let d = dt , let v = try? coder.decode(AuthResponse.self, from: d as! Data) else {
                return nil
            }
            return v
        }
    }
}
/*
public enum UserKeys:String {
    case auth = "auth"
    case configs = "configs"
}

func read(key:UserKeys) -> Any?{
    let preferences = UserDefaults.standard
    
    let key = "value"
    var value:Any?
    if preferences.object(forKey: key) == nil {
        //  Doesn't exist
    } else {
        value = preferences.string(forKey: key)
    }
    return value
}


func write(key:String, value:String){
    let preferences = UserDefaults.standard
    preferences.set(value, forKey: key)
    
    //  Save to disk
    let didSave = preferences.synchronize()
    
    if !didSave {
        //  Couldn't save (I've never seen this happen in real world testing)
    }
}
*/

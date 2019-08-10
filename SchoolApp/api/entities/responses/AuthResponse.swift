//
//  AuthResponse.swift
//  MyApp
//
//  Created by X on 4/27/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {
    let id: Int?
    let userLogin, userPass, userNicename, userEmail: String?
    let userURL, userRegistered, userActivationKey: String?
    let userStatus: Int?
    let displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userLogin = "user_login"
        case userPass = "user_pass"
        case userNicename = "user_nicename"
        case userEmail = "user_email"
        case userURL = "user_url"
        case userRegistered = "user_registered"
        case userActivationKey = "user_activation_key"
        case userStatus = "user_status"
        case displayName = "display_name"
    }
}

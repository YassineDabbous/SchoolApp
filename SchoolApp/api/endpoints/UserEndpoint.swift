//
//  UserEndpoint.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Alamofire
enum UserEndpoint: APIConfiguration {
    
    case login(email:String, password:String)
    case forgotten(email:String)
    case register(request:RegisterRequest)
    case logout
    case profile
    case updateAccount(request:AccountUpdateRequest)
    case changePassword(request:ChangePasswordRequest)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .login:
                return .post
            case .forgotten:
                return .post
            case .logout:
                return .post
            case .register:
                return .post
            case .profile:
                return .get
            case .updateAccount(let request):
                return .put
            case .changePassword(let request):
                return .put
        }
    }
    
    var httpBody: Data?{
        let encoder = JSONEncoder()
        switch self {
        case .login:
            return nil
        case .forgotten:
            return nil
        case .logout:
            return nil
        case .register(let request):
            return try! encoder.encode(request)
        case .profile:
            return nil
        case .updateAccount(let request):
            return try! encoder.encode(request)
        case .changePassword(let request):
            return try! encoder.encode(request)
        @unknown default:
            return nil
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .forgotten:
            return "/reset_password"
        case .logout:
            return "/logout"
        case .register:
            return "/register"
        case .profile:
            return "/account"
        case .updateAccount(let request):
            return "/account"
        case .changePassword(let request):
            return "/account/password"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
            case .login(let email, let password):
                return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
            case .forgotten(let email):
                return [K.APIParameterKey.email: email]
            case .logout:
                return nil
            case .register:
                return nil
            case .profile:
                return nil
            case .updateAccount(let request):
                return nil
            case .changePassword(let request):
                return nil
        }
    }
    
    
}

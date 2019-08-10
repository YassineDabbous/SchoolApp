//
//  CategoriesEndpoint.swift
//  MyApp
//
//  Created by X on 4/25/19.
//  Copyright © 2019 X. All rights reserved.
//


import Alamofire
enum CategoriesEndpoint: APIConfiguration {
    
    case parents
    case children(id: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .parents:
                return .get
            case .children:
                return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
            case .parents:
                return "/categories"
            case .children(let id):
                return "/categories/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
            case .parents:
                return nil
            case .children:
                return nil
        }
    }
    
    
    var httpBody: Data?{
        //let encoder = JSONEncoder()
        switch self {
        case .parents:
            return nil
        case .children:
            return nil
        }
    }
    
}




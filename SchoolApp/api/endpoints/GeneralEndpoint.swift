//
//  GeneralEndpoint.swift
//  MyApp
//
//  Created by X on 4/30/19.
//  Copyright © 2019 X. All rights reserved.
//


import Alamofire
enum GeneralEndpoint: APIConfiguration {
    
    case ads
    case page(id: Int)
    case notifications
    case countries
    case slideshows
    case languages
    case product_classes
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .ads:
                return .get
            case .page:
                return .get
            case .notifications:
                return .get
            case .countries:
                return .get
            case .slideshows:
                return .get
            case .languages:
                return .get
        case .product_classes:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
            case .notifications:
                return "/notifications"
            case .ads:
                return "/ads"
            case .page(let id):
                return "/information/\(id)"
        case .countries:
            return "/countries"
        case .slideshows:
            return "/slideshows"
        case .languages:
            return "/languages"
        case .product_classes:
            return "/product_classes"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
            case .ads:
                return nil
            case .page:
                return nil
            case .notifications:
                return nil
            case .countries:
                return nil
            case .slideshows:
                return nil
            case .languages:
                return nil
        case .product_classes:
            return nil
        }
    }
    
    
    var httpBody: Data?{
        //let encoder = JSONEncoder()
        switch self {
            case .ads:
                return nil
            case .page:
                return nil
            case .notifications:
                return nil
            case .countries:
                return nil
            case .slideshows:
                return nil
            case .languages:
                return nil
        case .product_classes:
            return nil
        }
    }
    
}





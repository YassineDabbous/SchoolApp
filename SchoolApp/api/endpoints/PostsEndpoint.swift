//
//  postsEndpoint.swift
//  MyApp
//
//  Created by X on 4/17/19.
//  Copyright © 2019 X. All rights reserved.
//

import Alamofire
enum PostsEndpoint: APIConfiguration {
    
    case uploadFiles
    case posts(id: Int)
    case post(id: Int)
    case search(word: String)
    
    var httpBody: Data?{
        let encoder = JSONEncoder()
        switch self {
            case .uploadFiles:
                return nil
            case .posts:
                return nil
            case .post(let id):
                return nil
            case .search(let word):
                return nil
            @unknown default:
                return nil
        }
    }
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .uploadFiles:
                return .post
            case .posts:
                return .get
            case .post:
                return .get
            case .search:
                return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
            case .uploadFiles:
                return "/files"
            case .posts(let id):
                return "/posts/\(id)"
            case .post(let id):
                return "/posts/\(id)"
            case .search(let word):
                return "search?q=\(word)"

        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
            case .uploadFiles:
                return nil
            case .posts:
                return nil
            case .post:
                return nil
            case .search:
                return nil
        }
    }
    
    
}

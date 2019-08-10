//
//  Constants.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

typealias MyResult<T> = Result<T,BackendError> // Result<T,BackendError>

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.uae-zad.com/public/api/v1"
        static let baseURL2 = "http://opencart3-simple.api.opencart-api.com/api/rest"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

/*let headers: HTTPHeaders = [
    "X-Oc-Merchant-Id": "ywVSIexBhfKEWtEIkib8aCJsaSYhZMSC"/*,
     "X-Oc-Session": "i50djcan9d2ms99vauskpfm695",
     "X-Oc-Merchant-Language": "en",
     "X-Oc-Image-Dimension": "400"
     //,"X-Oc-Store-Id": "1"*/
]*/
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    
    case merchantID = "X-Oc-Merchant-Id"
    case session = "X-Oc-Session"
    case language = "X-Oc-Merchant-Language"
}

enum ContentType: String {
    case json = "application/json"
}


enum AuthValues:String {
    case server1
    case server2
    
    var apiKey: String {
        switch self {
            case .server1:
                return "ywVSIexBhfKEWtEIkib8aCJsaSYhZMSC"
            case .server2:
                return "123"
        }
    }
    
    var sessionKey: String {
        switch self {
        case .server1:
            let session = UserDefaults.init().string(forKey: "session") ?? "30pni6hu4met004o5ege15utc4"
            return session
        case .server2:
            return "29a2eeb983fdac33d9c9da3f78"
        }
    }
    
}
enum StoreOptions:String {
    case server1
    case server2
    
    var language: String {
        var l = Locale.current.languageCode ?? "en-gb"
        if l.elementsEqual("en") {
            l = "en-gb";
        }
        return l
    }
    
    var sessionKey: String {
        switch self {
        case .server1:
            let session = UserDefaults.init().string(forKey: "session") ?? "30pni6hu4met004o5ege15utc4"
            return session
        case .server2:
            return "29a2eeb983fdac33d9c9da3f78"
        }
    }
    
}

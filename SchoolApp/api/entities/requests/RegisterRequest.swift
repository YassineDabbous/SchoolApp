//
//  RegisterRequest.swift
//  MyApp
//
//  Created by X on 4/27/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
struct RegisterRequest: Codable {
    let name, email, password: String
    
    init(firstname:String, email:String, password:String){
        self.name = firstname
        self.email = email
        self.password = password
        
    }
    enum CodingKeys: String, CodingKey {
        case password, name, email
    }
}

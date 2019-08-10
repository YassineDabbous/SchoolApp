//
//  AccountUpdateRequest.swift
//  MyApp
//
//  Created by X on 5/2/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
struct AccountUpdateRequest: Codable {
    let firstname, lastname, email, telephone, fax: String?
}

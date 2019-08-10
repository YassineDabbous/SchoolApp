//
//  ChangePasswordRequest.swift
//  MyApp
//
//  Created by X on 5/2/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
struct ChangePasswordRequest: Codable {
    let password, confirm: String?
}

//
//  QuestionRequest.swift
//  SchoolApp
//
//  Created by X on 7/15/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

struct QuestionRequest: Codable {
    let title, description, parent, uid: String?
}


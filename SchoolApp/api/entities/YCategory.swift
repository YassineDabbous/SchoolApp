//
//  Category.swift
//  MyApp
//
//  Created by X on 4/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
//http://api.uae-zad.com/public/api/v1/get_categories
//http://api.uae-zad.com/public/api/v1/get_sup_categories?parent_id=84
struct CategoriesResponse: Codable {
    let status: Bool?
    let info: [YCategory]?
}


struct YCategory: Codable {
    let id: Int?
    let name: String?
    let termOrder, childNumber: Int?
    let postsNumber: String?
    //let icon: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case termOrder = "term_order"
        case childNumber = "child_number"
        case postsNumber = "posts_number"
        //case icon
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


//
//  AllTypes.swift
//  MyApp
//
//  Created by X on 5/17/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

enum IntegerString: Codable {
    case integer(Int)
    case string(String)
    
    func asInt() -> Int {
        switch self {
            case .integer(let v):
                return v
            case .string(let v):
                return Int(v)!
        }
    }
    func asString() -> String {
            switch self {
                case .integer(let v):
                    return "\(v)"
                case .string(let v):
                    return v
            }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(NSValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

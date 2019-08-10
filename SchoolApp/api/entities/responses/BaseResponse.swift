//
//  BaseResponse.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

class BaseResponse<T: Decodable> : Decodable {
    public var success:Bool = true
    public var message:String? = ""
    public var error:[String]?  = []
    ///public var data:T?
    public var data:DataUnion<T>?
}
enum DataUnion<T: Decodable>: Decodable {
    case dataClass(T)
    case stringArray([String])
    
    func getData() -> T? {
        switch self {
        case .dataClass(let d):
            return d
        case .stringArray(_ ):
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(T.self) {
            self = .dataClass(x)
            return
        }
        throw DecodingError.typeMismatch(DataUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }
    
    
    /*func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dataClass(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }*/
}

//
//  Error.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
import Alamofire

public enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

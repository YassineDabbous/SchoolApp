//
//  AppModels.swift
//  Swift Clean Architecture
//
//  Created by Basem Emara on 2018-04-18.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

enum AppModels {
    
    struct Error {
        let title: String
        let message: String?
        
        static func fromDataError(error:DataError) -> AppModels.Error {
            var msg = "Product not found"
            switch error {
            case .noInternet:
                msg = "not internet"
            default:
                msg = "internal problem"
            }
            return AppModels.Error(title: "Product Problem", message: msg)
        }
    }
}

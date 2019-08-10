//
//  AuthRouter.swift
//  MyApp
//
//  Created by X on 4/27/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

struct AuthRouter{
    weak var viewController:UIViewController?
    init(viewController:UIViewController) {
        self.viewController = viewController
    }
}

extension AuthRouter: AppRoutable{
    func register() {
        show(destination: RegisterViewController()){ controller in
        }
    }
    func recover() {
        show(destination: ResetViewController()){ controller in
        }
    }
}

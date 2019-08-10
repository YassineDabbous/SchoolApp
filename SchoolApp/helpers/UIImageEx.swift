//
//  UIImageEx.swift
//  SchoolApp
//
//  Created by X on 8/5/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
extension UIImage {
    var jpeg: Data? {
        return jpegData(compressionQuality:1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return self.pngData()
    }
}

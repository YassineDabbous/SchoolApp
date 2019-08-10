//
//  CellDescriptor.swift
//  MyApp
//
//  Created by X on 4/20/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

struct CellDescriptor {
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()
    
    init<T: UITableViewCell>(configure: @escaping (T) -> ()) {
        self.cellClass = T.self
        self.reuseIdentifier = String(describing: T.self)
        self.configure = { cell in
            configure(cell as! T)
        }
    }
}

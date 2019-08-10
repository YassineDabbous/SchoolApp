//
//  FreezedTableView.swift
//  SchoolApp
//
//  Created by X on 8/5/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

//table will adjust to its size to not require scrolling vertically

class FreezedTableView: UITableView {
    override var contentSize: CGSize {
        didSet{
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

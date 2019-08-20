//
//  Labels.swift
//  SchoolApp
//
//  Created by X on 8/20/19.
//  Copyright © 2019 X. All rights reserved.
//


import UIKit

class LabelRegular:UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        numberOfLines = 0
        font = UIFont(name: "Cairo-Regular", size: 14)
    }
}
class LabelBold:LabelRegular {
    override func setup() {
        numberOfLines = 0
        font = UIFont(name: "Cairo-Bold", size: 14)
    }
}

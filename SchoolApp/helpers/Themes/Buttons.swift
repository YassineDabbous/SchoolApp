//
//  Themes.swift
//  MyApp
//
//  Created by X on 5/12/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class BtnPrimary:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
     func setup() {
        backgroundColor = Utils.appColor
        tintColor = .white
        layer.cornerRadius = 4
        titleLabel?.font = UIFont(name: "Cairo-Regular", size: 14)
    }
}

class BtnSecondary:BtnPrimary{
    override func setup() {
        super.setup()
        backgroundColor = .white
        setTitleColor(Utils.appColor, for: .normal)
        //titleLabel?.textColor = Utils.appColor
        layer.borderWidth = 1
        layer.borderColor = Utils.appColor.cgColor
    }
}
class BtnDanger:BtnPrimary{
    override func setup() {
        super.setup()
        backgroundColor = .red
    }
}

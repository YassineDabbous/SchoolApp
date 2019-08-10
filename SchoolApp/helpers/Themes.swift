//
//  Themes.swift
//  MyApp
//
//  Created by X on 5/12/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class Input:UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        bounds = bounds.inset(by: padding)
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }
    override func draw(_ rect: CGRect) {
        anchor(size: CGSize(width: 0, height: 40))
        layoutIfNeeded()
    }
}
class TextArea:UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        bounds = bounds.inset(by: padding)
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }
}

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

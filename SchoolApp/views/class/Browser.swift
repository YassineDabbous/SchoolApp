//
//  Browser.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class Browser: UIView {

    var card:UIView!
    var browser:UIWebView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadMe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadMe()
    }
    func loadMe() {
        
        browser = UIWebView(frame: .zero)
        self.addSubview(browser)
        browser.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                       padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8.0
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
    }
}

//
//  HeaderView.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class HeaderView: GenericCollectionViewCell<String> {
    
    var titleView: UILabel!
    
    override func loadMe() {
        
        titleView = UILabel()
        self.addSubview(titleView)
        titleView.anchor(centerX: card.centerXAnchor, centerY: card.centerYAnchor)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .white
        card.backgroundColor = .white
        
        card.layer.borderColor = Utils.appColor.cgColor
        card.layer.borderWidth = 1
        card.layer.masksToBounds = false
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowOpacity = 0.5
        
        card.clipsToBounds = true
        card.layer.cornerRadius = 20
        //card.layer.maskedCorners = [.layerMinXMinYCorner]
        
        titleView.textColor = Utils.appColor
    }

}

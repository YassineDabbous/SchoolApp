//
//  NotificationCell.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/15/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class NotificationCell: GenericTableViewCell<YNotification> {
        
    var titleView: UILabel!
    var typeView: UILabel!
    var timeView: UILabel!
    
    
    override func loadMe() {
        
        titleView = UILabel()
        card.addSubview(titleView)
        titleView.atTop(of: card)
        
        typeView = UILabel()
        card.addSubview(typeView)
        typeView.anchor(top: titleView.bottomAnchor, leading: card.leadingAnchor, bottom: card.bottomAnchor, size: CGSize(width: 60, height: 0))
        
        
        timeView = UILabel()
        card.addSubview(timeView)
        timeView.anchor(top: titleView.bottomAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor)
        
        
        
    }
    
    override func draw(_ rect: CGRect) {
        
        card.backgroundColor = UIColor.white
        card.layer.borderColor = Utils.appColor.cgColor
        card.layer.borderWidth = 1
        card.layer.masksToBounds = false
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowOpacity = 0.5
        
        titleView.numberOfLines = 0
        
        timeView.textAlignment = .right
    }
    
    override func bind() {
        titleView.text = item!.message
        typeView.text = item!.type
        timeView.text = item!.ago
    }
    
}

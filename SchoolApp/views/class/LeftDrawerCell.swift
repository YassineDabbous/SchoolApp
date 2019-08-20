//
//  LeftDrawerCell.swift
//  MyApp
//
//  Created by X on 4/25/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class LeftDrawerCell: GenericTableViewCell<MenuItem> {

    var titleView: UILabel!
    var imgView: UIImageView!
    
    
    override func loadMe() {
        
        print("view size", frame.size.height)
        
        
        imgView = UIImageView(image: UIImage(named: "pencil"))
        self.addSubview(imgView)
        imgView.anchor(leading: card.leadingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                       size: CGSize(width: 24, height: 24))
        
        
        titleView = LabelBold()
        self.addSubview(titleView)
        titleView.anchor(top: card.topAnchor, leading: imgView.trailingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
        print("view loaded")
    }
    
    override func bind(){
        titleView.text = NSLocalizedString(item!.type.rawValue, comment: item!.type.rawValue)
        imgView.image = UIImage(named: item!.icon)
    }
}

//
//  ListCategoryCell.swift
//  SchoolApp
//
//  Created by X on 7/14/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class ListCategoryCell: GenericCollectionViewCell<YCategory>  {
    
    var countView: UILabel!
    var titleView: UILabel!
    
    
    override func loadMe() {
        
        let imgView = UIImageView(image: UIImage(named: "pencil"))
        self.addSubview(imgView)
        imgView.anchor(leading: card.leadingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                       size: CGSize(width: 24, height: 24))
        
        
        countView = UILabel()
        self.addSubview(countView)
        countView.anchor(top: card.topAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
                         size: CGSize(width: 24, height: 0))
        
        titleView = LabelBold()
        self.addSubview(titleView)
        titleView.anchor(top: card.topAnchor, leading: imgView.trailingAnchor, bottom: card.bottomAnchor, trailing: countView.leadingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
        
        print("view loaded")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        backgroundColor = .white
        
        card.backgroundColor = .white
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.gray.cgColor
        card.clipsToBounds = true
        card.layer.cornerRadius = 4
        
        titleView.textColor = Utils.appColor
        
        countView.textAlignment = .center
        countView.textColor = .white
        countView.backgroundColor = Utils.appColor
        countView.layer.cornerRadius = 18
        countView.clipsToBounds = true
    }
    override func bind() {
        titleView.text = item!.name
        let c = (item!.childNumber! == 0) ? item!.postsNumber! : "\(item!.childNumber!)"
        countView.text = c
    }
}

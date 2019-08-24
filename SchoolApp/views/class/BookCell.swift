//
//  BookCell.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/7/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class BookCell: GenericTableViewCell<Post> {
    
    var titleView: UILabel!
    
    override func loadMe() {

        
        let imgView = UIImageView(image: UIImage(named: "pencil"))
        self.addSubview(imgView)
        imgView.anchor(leading: card.leadingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                       size: CGSize(width: 24, height: 24))
        
        
        titleView = LabelBold()
        titleView.numberOfLines = 0
        self.addSubview(titleView)
        titleView.anchor(top: card.topAnchor, leading: imgView.trailingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
        
    }
    
    override func draw(_ rect: CGRect) {
        
        backgroundColor = .white
        
        card.backgroundColor = .white
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.gray.cgColor
        card.clipsToBounds = true
        card.layer.cornerRadius = 4
        
        titleView.textColor = .gray
    }
    
    override func bind() {
        titleView.text = item!.postTitle
    }
    
}

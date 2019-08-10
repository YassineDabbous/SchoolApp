//
//  SearchView.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/10/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class SearchView: UIView {

    var card: UIView!
    var searchInput: UITextField!
    var searchImage: UIImageView!
    
    func drawMe(){
        
        card = UIView(frame: .zero)
        self.addSubview(card)
        card.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                    padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
        
        
        let imgView = UIImageView(image: UIImage(named: "magnify"))
        self.addSubview(imgView)
        imgView.anchor(trailing: card.trailingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                       size: CGSize(width: 24, height: 24))
        searchImage = imgView
        
        
        
        searchInput = UITextField(frame: .zero)
        self.addSubview(searchInput)
        searchInput.anchor(top: card.topAnchor, leading: card.leadingAnchor, bottom: card.bottomAnchor, trailing: searchImage.leadingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawMe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawMe()
    }
    
    override func draw(_ rect: CGRect){
        backgroundColor = .clear
        
        card.backgroundColor = .white
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.gray.cgColor
        card.clipsToBounds = true
        card.layer.cornerRadius = 4
        
        searchInput.placeholder = "What do you search?"
        
        //card.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}

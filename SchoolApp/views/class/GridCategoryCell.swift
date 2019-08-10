//
//  CategoryCell.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/6/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class GridCategoryCell: GenericCollectionViewCell<YCategory>  {
    
    var countView: UILabel!
    var titleView: UILabel!
    var internalClass: UILabel!
    
    
    override func loadMe() {
        
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tv.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        self.titleView = tv
        
        
        countView = UILabel()
        countView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countView)
        NSLayoutConstraint.activate([
            countView.heightAnchor.constraint(equalToConstant: CGFloat(20)),
            countView.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            countView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),
            countView.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -16),
            ])
        
        
        internalClass = UILabel()
        internalClass.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(internalClass)
        NSLayoutConstraint.activate([
            internalClass.heightAnchor.constraint(equalToConstant: CGFloat(20)),
            internalClass.widthAnchor.constraint(equalToConstant: CGFloat(100)),
            internalClass.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),
            internalClass.rightAnchor.constraint(equalTo: countView.leftAnchor, constant: 8),
            ])
        
        
        
        print("view loaded")
    }
    
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .white
        card.backgroundColor = .white
        self.card.layer.borderWidth = 2
        self.card.layer.borderColor = Utils.appColor.cgColor
        self.titleView.textColor = Utils.appColor
        self.countView.textColor = Utils.appColor
        self.internalClass.textColor = Utils.appColor
        
        internalClass.text = "items"
        countView.font = self.countView.font.withSize(self.frame.width/12)
        titleView.font = self.titleView.font.withSize(self.frame.width/10)
        internalClass.font = self.internalClass.font.withSize(self.frame.width/12)
    }
    override func bind() {
        titleView.text = item!.name
        countView.text = item!.childNumber!.description
    }
    
}

//
//  AnswerCell.swift
//  SchoolApp
//
//  Created by X on 7/16/19.
//  Copyright © 2019 X. All rights reserved.
//


import UIKit

class AnswerCell: GenericTableViewCell<Answer> {
    
    var titleView: UILabel!
    var descriptionView: UILabel!
    
    override func loadMe() {
        let imgView = UIImageView(image: UIImage(named: "pencil"))
        self.addSubview(imgView)
        imgView.anchor(leading: card.leadingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                       size: CGSize(width: 24, height: 24))
    
        
        descriptionView = LabelBold()
        self.addSubview(descriptionView)
        
        
        titleView = LabelRegular()
        self.addSubview(titleView)
        
        let stack = UIStackView(arrangedSubviews: [titleView, descriptionView])
        stack.axis = .vertical
        stack.spacing = 5
        card.addSubview(stack)
        stack.anchor(top: card.topAnchor, leading: imgView.trailingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor,
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
        
        descriptionView.numberOfLines = 0
    }
    
    override func bind() {
        descriptionView.text = item!.postContent
        titleView.text = item!.postTitle
    }
    
}

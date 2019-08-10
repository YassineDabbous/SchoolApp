//
//  QuestionCell.swift
//  SchoolApp
//
//  Created by X on 7/16/19.
//  Copyright © 2019 X. All rights reserved.
//


import UIKit

class QuestionCell: GenericTableViewCell<Question> {
    
    var titleView: LabelBold!
    var answeredLabel: UILabel!
    
    override func loadMe() {
        
        answeredLabel = UILabel()
        self.addSubview(answeredLabel)
        answeredLabel.anchor(leading: card.leadingAnchor, centerY: card.centerYAnchor,
                       padding: UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8),
                       size: CGSize(width: 50, height: 50))
        
        
        titleView = LabelBold()
        self.addSubview(titleView)
        titleView.anchor(top: card.topAnchor, leading: answeredLabel.trailingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor,
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
        
        answeredLabel.textColor = .white
        answeredLabel.adjustsFontSizeToFitWidth = true
        answeredLabel.clipsToBounds = true
        answeredLabel.layer.cornerRadius = 20
    }
    
    override func bind() {
        if item!.commentStatus!.elementsEqual("open") {
            answeredLabel.text = "Not Answered"
            answeredLabel.backgroundColor = .red
        } else {
            answeredLabel.text = "Answered"
            answeredLabel.backgroundColor = .green
        }
        titleView.text = item!.postTitle
    }
    
}

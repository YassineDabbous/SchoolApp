//
//  Printer.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class Printer: UIView {

    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var titleView: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        card.layer.cornerRadius = 10.0
        card.backgroundColor = UIColor.white
        card.layer.masksToBounds = false
        card.layer.shadowColor = UIColor.black.cgColor
        //card.layer.shadowColor = UIColor.red.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowOpacity = 0.5
    }
    

}

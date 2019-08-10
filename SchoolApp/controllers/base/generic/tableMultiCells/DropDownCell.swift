//
//  DropDownCell.swift
//  MyApp
//
//  Created by X on 5/10/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class DropDownCell: GenericTableViewCell<String> {
    
    var titleView: UILabel!
    
    override func loadMe() {
        titleView = LabelBold()
        self.addSubview(titleView)
        titleView.fill(parent: card)
    }
    
    override func bind() {
        titleView.text = item ?? "nil :/"
    }
    
}

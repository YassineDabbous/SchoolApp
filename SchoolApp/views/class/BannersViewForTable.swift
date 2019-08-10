//
//  BannersViewForTable.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/15/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class BannersViewForTable: UITableViewCell {

    @IBOutlet weak var main: UIView!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(){
        card1.layer.borderColor = Utils.appColor.cgColor
        card1.layer.borderWidth = 1
        card1.backgroundColor = UIColor.white
        card2.layer.borderColor = Utils.appColor.cgColor
        card2.layer.borderWidth = 1
        card2.backgroundColor = UIColor.white
        /*
         //self.card1.layer.cornerRadius = 10.0
         card1.layer.masksToBounds = false
         card1.layer.shadowColor = UIColor.black.cgColor
         card1.layer.shadowOffset = CGSize(width: 0, height: 2)
         card1.layer.shadowOpacity = 0.5
         */
        
        /*
         self.card2.layer.cornerRadius = 10.0
         card2.layer.masksToBounds = false
         card2.layer.shadowColor = UIColor.black.cgColor
         card2.layer.shadowOffset = CGSize(width: 0, height: 2)
         card2.layer.shadowOpacity = 0.5
         */
    }
}

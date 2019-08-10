//
//  BannersView.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/7/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class BannersView: UICollectionReusableView {
    
    @IBOutlet weak var main: UIView!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var card2: UIView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        /*
         self.card1.layer.cornerRadius = 10.0
         card1.backgroundColor = UIColor.white
         card1.layer.masksToBounds = false
         card1.layer.shadowColor = UIColor.black.cgColor
         card1.layer.shadowOffset = CGSize(width: 0, height: 2)
         card1.layer.shadowOpacity = 0.5
         
         self.card2.layer.cornerRadius = 10.0
         card2.backgroundColor = UIColor.white
         card2.layer.masksToBounds = false
         card2.layer.shadowColor = UIColor.black.cgColor
         card2.layer.shadowOffset = CGSize(width: 0, height: 2)
         card2.layer.shadowOpacity = 0.5
         */
        
        card1.layer.borderColor = Utils.appColor.cgColor
        card1.layer.borderWidth = 1
        card1.backgroundColor = UIColor.white
        card2.layer.borderColor = Utils.appColor.cgColor
        card2.layer.borderWidth = 1
        card2.backgroundColor = UIColor.white
    }
    
}

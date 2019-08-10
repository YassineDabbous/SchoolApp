//
//  CellsEx.swift
//  SchoolApp
//
//  Created by X on 8/5/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
extension UITableViewCell {
    
    func asCard(view:UIView) {
        contentView.backgroundColor = .white
        
        self.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        //view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.5
        //view.layer.borderWidth = 1
        
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
}
extension UICollectionViewCell {
    
    func asCard(view:UIView) {
        contentView.backgroundColor = .white
        
        
        self.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        //view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.5
        //view.layer.borderWidth = 1
        
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
}

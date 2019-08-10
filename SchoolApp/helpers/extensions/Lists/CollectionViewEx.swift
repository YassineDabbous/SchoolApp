//
//  CollectionViewEx.swift
//  SchoolApp
//
//  Created by X on 7/31/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

extension UICollectionView {
    func emptyMessage(message:String = "No Data", hide:Bool=false) {
        if !hide {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
            let messageLabel = LabelBold(frame: rect)
            messageLabel.text = message
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            
            self.backgroundView = messageLabel
        } else {
            self.backgroundView = nil
        }
    }
    func animateTable() {
        self.reloadData()
        let cells = self.visibleCells
        
        let tableViewHeight = self.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

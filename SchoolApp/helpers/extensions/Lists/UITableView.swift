//
//  UiTableView.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension UITableView {
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
            self.separatorStyle = .none
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

extension UITableView : GADBannerViewDelegate {

    func getAdmobCell(root:UIViewController) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "AdViewCell")
        cell?.backgroundColor = .orange
        
        let card = UIView(frame: .zero)
        cell?.addSubview(card)
        card.fill(parent: cell!, margin: 8)
        card.layer.cornerRadius = 4.0
        card.backgroundColor = .white
        
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.backgroundColor = .white
        bannerView.adUnitID = Utils.banner
        bannerView.delegate = self
        bannerView.rootViewController = root
        bannerView.load(GADRequest())
        
        card.addSubview(bannerView)
        bannerView.fill(parent: card)
        return cell!
    }

}

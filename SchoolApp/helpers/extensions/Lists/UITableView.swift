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
            let cell:AdViewCell = dequeueReusableCell(withIdentifier: "AdViewCell") as! AdViewCell
            //cell.backgroundColor = UIColor.clear
            //cell.contentView.backgroundColor = UIColor.clear
            cell.card.layer.cornerRadius = 4.0
            cell.card.backgroundColor = UIColor.white
        
            let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            bannerView.backgroundColor = UIColor.white
            bannerView.adUnitID = Utils.banner
            bannerView.delegate = self
            bannerView.rootViewController = root
            bannerView.load(GADRequest())
            bannerView.autoresizesSubviews = true
            bannerView.center = cell.card.convert(cell.card.center, from: cell.card.superview)
        bannerView.autoresizingMask = UIView.AutoresizingMask(rawValue: (UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue))
        
        for v in cell.card.subviews{
            v.removeFromSuperview()
        }
            cell.card.addSubview(bannerView)
            //bannerView.frame = CGRect(x: 0, y: 0, width: cell.card.frame.width, height: cell.card.frame.height)
            return cell
    }

}

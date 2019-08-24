//
//  CollectionViewEx.swift
//  SchoolApp
//
//  Created by X on 7/31/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import GoogleMobileAds

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
extension UICollectionView : GADBannerViewDelegate {
    
    func getAdmobCell(_ root:UIViewController, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "AdViewCell", for: indexPath)
        cell.backgroundColor = .orange
        
        let card = UIView(frame: .zero)
        cell.addSubview(card)
        card.fill(parent: cell, margin: 8)
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
        
        /*bannerView.autoresizesSubviews = true
        bannerView.center = card.convert(card.center, from: card.superview)
        bannerView.autoresizingMask = UIView.AutoresizingMask(rawValue: (UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue))
        
        for v in card.subviews{
            v.removeFromSuperview()
        }
        card.addSubview(bannerView)*/
        //bannerView.frame = CGRect(x: 0, y: 0, width: cell.card.frame.width, height: cell.card.frame.height)
        return cell
    }
    
}

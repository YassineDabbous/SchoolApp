//
//  BaseControllerAds.swift
//  SchoolApp
//
//  Created by X on 7/11/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension BaseViewController {
    
    public func increasePages(){
        Utils.print("increasePages")
        BaseViewController.admob_interstitial_pages_current_count = BaseViewController.admob_interstitial_pages_current_count+1
        BaseViewController.admob_interstitial_clicks_current_count = BaseViewController.admob_interstitial_clicks_current_count+1
    }
    public func increase(){
        Utils.print("increase")
        BaseViewController.admob_interstitial_clicks_current_count = BaseViewController.admob_interstitial_clicks_current_count+1
    }
    public func reset(){
        if(BaseViewController.admob_interstitial_mode==0){
            BaseViewController.admob_interstitial_last_count = BaseViewController.admob_interstitial_pages_current_count
        }else{
            BaseViewController.admob_interstitial_last_count = BaseViewController.admob_interstitial_clicks_current_count
        }
    }
    public func showInterstitial(){
        Utils.print("showInterstitial if mInterstitialAd.isLoaded() && canShowInterstitial(context)");
        if (BaseViewController.interstitialView.isReady && canShowInterstitial()){
            print("show el Interstitial");
            BaseViewController.interstitialView.present(fromRootViewController:self)
            reset()
        }
    }
    public func canShowInterstitial() -> Bool{
        Utils.print([
            "BaseViewController.admob_interstitial_mode", BaseViewController.admob_interstitial_mode,
            "admob_interstitial_pages", BaseViewController.admob_interstitial_pages,
            "admob_interstitial_clicks", BaseViewController.admob_interstitial_clicks,
            "pages_current_count", BaseViewController.admob_interstitial_pages_current_count,
            "clicks_current_count", BaseViewController.admob_interstitial_clicks_current_count,
            "last_count", BaseViewController.admob_interstitial_last_count,
            ]);
        Utils.print("showInterstitial if mInterstitialAd.isLoaded() && canShowInterstitial(context)");
        let can = UserDefaults.standard.bool(forKey: "admob_activation")
        if(can && (BaseViewController.admob_interstitial_mode == 0) && ((BaseViewController.admob_interstitial_pages_current_count-BaseViewController.admob_interstitial_last_count) >= BaseViewController.admob_interstitial_pages) ){
            return true;
        }else if(can && (BaseViewController.admob_interstitial_mode == 1) && ((BaseViewController.admob_interstitial_clicks_current_count-BaseViewController.admob_interstitial_last_count) >= BaseViewController.admob_interstitial_clicks) ){
            return true;
        }
        return false;
    }
    
    
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.backgroundColor = .white
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 5),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .right,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .right,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .left,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .left,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    
    
    
    func createAd() {
        Utils.print("creating GADInterstitial ...")
        BaseViewController.interstitialView = GADInterstitial(adUnitID: Utils.interstitial)
        BaseViewController.interstitialView.delegate = self
        let request = GADRequest()
        BaseViewController.interstitialView.load(request)
    }
    
    
}

extension BaseViewController : GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(currentVc: UIViewController, ad: GADInterstitial!) {
        Utils.print("Ad Received")
        /*if ad.isReady {
         interstitialView.present(fromRootViewController: currentVc)
         }*/
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        Utils.print("Did Dismiss Screen")
        createAd()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        Utils.print("Will Dismiss Screen")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        Utils.print("Will present screen")
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        Utils.print("Will leave application")
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        Utils.print("Failed to present screen")
        createAd()
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        Utils.print("\(ad) did fail to receive ad with error \(error)")
    }
}


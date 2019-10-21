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
    
    
    public func printAds(_ vars:Any){
        Swift.print("For_Ads:", String(describing:vars))
    }
    
    func reinit(){
        BaseViewController.admob_interstitial_clicks_current_count = 0
        BaseViewController.admob_interstitial_pages_current_count = 0
        BaseViewController.admob_interstitial_last_count = 0
    }

    func showBannerAd(){
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = Utils.banner
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    public func increasePages(){
        printAds("increasePages")
        BaseViewController.admob_interstitial_pages_current_count = BaseViewController.admob_interstitial_pages_current_count+1
        BaseViewController.admob_interstitial_clicks_current_count = BaseViewController.admob_interstitial_clicks_current_count+1
    }
    public func increase(){
        printAds("increase")
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
        printAds("if mInterstitialAd isLoaded && canShowInterstitial()");
        printAds("interstitialView.isReady: \(BaseViewController.interstitialView.isReady)")
        if (BaseViewController.interstitialView.isReady && canShowInterstitial()){
            printAds("show el Interstitial");
            BaseViewController.interstitialView.present(fromRootViewController:self)
            reset()
        }
    }
    public func canShowInterstitial() -> Bool{
        /*printAds([
            "BaseViewController.admob_interstitial_mode", BaseViewController.admob_interstitial_mode,
            "admob_interstitial_pages", BaseViewController.admob_interstitial_pages,
            "admob_interstitial_clicks", BaseViewController.admob_interstitial_clicks,
            "pages_current_count", BaseViewController.admob_interstitial_pages_current_count,
            "clicks_current_count", BaseViewController.admob_interstitial_clicks_current_count,
            "last_count", BaseViewController.admob_interstitial_last_count,
            ]);*/
        printAds("showInterstitial if mInterstitialAd.isLoaded() && canShowInterstitial(context)");
        let can = true //UserDefaults.standard.bool(forKey: "admob_activation")
        printAds("can ? \(can)")
        if(can && (BaseViewController.admob_interstitial_mode == 0) && ((BaseViewController.admob_interstitial_pages_current_count-BaseViewController.admob_interstitial_last_count) >= BaseViewController.admob_interstitial_pages) ){
            printAds("can afer condition ? true")
            return true;
        }else if(can && (BaseViewController.admob_interstitial_mode == 1) && ((BaseViewController.admob_interstitial_clicks_current_count-BaseViewController.admob_interstitial_last_count) >= BaseViewController.admob_interstitial_clicks) ){
            printAds("can afer condition 2 ? true")
            return true;
        }
        printAds(" can't show ads 3:) ")
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
    
    
    
    
    
    
}

extension AppDelegate : GADInterstitialDelegate {
    
    public func printAds(_ vars:Any){
        Swift.print("For_Ads:", String(describing:vars))
    }
    
    func createAd() {
        printAds("creating GADInterstitial ...")
        BaseViewController.interstitialView = GADInterstitial(adUnitID: Utils.interstitial)
        BaseViewController.interstitialView.delegate = self
        let request = GADRequest()
        BaseViewController.interstitialView.load(request)
        //reinit()
    }
    
    func interstitialDidReceiveAd(currentVc: UIViewController, ad: GADInterstitial!) {
        printAds("Ad Received")
        /*if ad.isReady {
         interstitialView.present(fromRootViewController: currentVc)
         }*/
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        printAds("Ad Received")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        printAds("Did Dismiss Screen")
        createAd()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        printAds("Will Dismiss Screen")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        printAds("Will present screen")
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        printAds("Will leave application")
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        printAds("fail")
        printAds("Failed to present screen")
        printAds("fail")
        createAd()
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        printAds("fail")
        printAds("\(ad) did fail to receive ad with error \(error)")
        printAds("fail")
    }
}


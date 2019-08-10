//
//  DocumentViewController.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds
import EventKit
import YouTubePlayer

class DocumentViewController: BaseViewController {
    
    
    
    //var admobDelegate = AdMobDelegate()
    public var file:Post = Post()
    
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    var items:[YSubject] = []
    var cats:[YCategory] = []
    let fetcher:Fetcher = Fetcher()
    //DB_FEATURE let db:Db = Db()
    let utils:Utils = Utils()
    
    
    var headerView:HeaderView!
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Document"
        print("loadViewwwwwwwwwwwwwwww")
        
        drawMainView()
        
        /*headerView = HeaderView()
        self.main.addSubview(headerView)
        headerView.anchor(top: main.topAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor,
                          padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
                          size: CGSize(width: 0, height: 40))*/
        
        
        
        print("viewwwwwwwwwwwwww loaded")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //headerView.titleView.text = file.postTitle
        
        //webView.browser.navigationDelegate = self
        //webView.browser.allowsBackForwardNavigationGestures = true
        
        
        let url = URL(string: file.docURL ?? Utils.server_url)!
        
        if file.docURL!.contains("youtube") {
            let videoPlayer = YouTubePlayerView(frame: .zero)
            self.main.addSubview(videoPlayer)
            videoPlayer.fill(parent: main)
            //videoPlayer.anchor(top: headerView.bottomAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 50, right: 4))
            videoPlayer.loadVideoURL(url)
            
            
        } else {
            let webView:Browser! = Browser(frame: .zero)
            self.main.addSubview(webView)
            webView.fill(parent: main)
            //webView.anchor(top: headerView.bottomAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 50, right: 4))
            
            if file.docURL != nil {
                webView.browser.loadRequest(URLRequest(url: url))
            } else {
                webView.browser.loadHTMLString(file.postContent!, baseURL: url)
            }
        }
        
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "admob_activation") {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            addBannerViewToView(bannerView)
            bannerView.adUnitID = Utils.banner
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
        
        //DB_FEATURE db.setReadedAt(id: file.id)
    }
    
    
}

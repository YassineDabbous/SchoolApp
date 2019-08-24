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

class DocumentViewController: BaseViewController, YouTubePlayerDelegate {
    
    
    public var file:Post = Post()
    
    override func loadView() {
        super.loadView()
        
        navigationItem.title = .localized(.File)
        
        drawMainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let right0 = UIBarButtonItem(image: UIImage(named:"share"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.share))
        let right1 = UIBarButtonItem(image: UIImage(named:"download"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.download))
        navigationItem.rightBarButtonItems = [right0, right1]
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        hideIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webView.browser.navigationDelegate = self
        //webView.browser.allowsBackForwardNavigationGestures = true
        
        var elUrl = file.youtubeURL ?? file.docURL ?? Utils.server_url
        elUrl = elUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  ?? Utils.server_url
        print("elUrl", elUrl)
        if let url = URL(string: elUrl) {
            if elUrl.contains("youtube") {
                let videoPlayer = YouTubePlayerView(frame: .zero)
                self.main.addSubview(videoPlayer)
                videoPlayer.fill(parent: main)
                videoPlayer.delegate = self
                showIndicator()
                videoPlayer.loadVideoURL(url)
            } else {
                let webView:Browser! = Browser(frame: .zero)
                self.main.addSubview(webView)
                webView.fill(parent: main)
                showIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    self.hideIndicator()
                })
                if file.docURL != nil {
                    webView.browser.loadRequest(URLRequest(url: url))
                } else {
                    webView.browser.loadHTMLString(file.postContent!, baseURL: url)
                }
            }
        } else {
            print("couldn't parse url", elUrl)
            Alerts.showAlert(vc: self, title: "", message:"Can't open this url"){
                self.dismissMe()
            }
        }
        
        
        
        
    }
    
    @objc func share(){
        let t = "\(file.postTitle!) \(file.docURL ?? file.youtubeURL ?? Utils.server_url)"
        AppHelper.shareText(vc: self, text: t)
    }
    @objc func download(){
        let t = file.docURL ?? file.youtubeURL ?? Utils.server_url
        routerMain.present(safari: t)
    }
}

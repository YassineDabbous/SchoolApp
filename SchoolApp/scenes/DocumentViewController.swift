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
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        hideIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webView.browser.navigationDelegate = self
        //webView.browser.allowsBackForwardNavigationGestures = true
        
        let elUrl = file.youtubeURL ?? file.docURL ?? Utils.server_url
        let url = URL(string: elUrl)!
        
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
            if file.docURL != nil {
                webView.browser.loadRequest(URLRequest(url: url))
            } else {
                webView.browser.loadHTMLString(file.postContent!, baseURL: url)
            }
        }
        
        
    }
    
    
}

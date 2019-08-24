//
//  BrowserViewController.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BrowserViewController: BaseViewController {
    
    public var url = Utils.url_privacy
    var webView:Browser!
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        webView = Browser(frame: .zero)
        self.main.addSubview(webView)
        webView.fill(parent: main)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  ?? Utils.server_url
        print("url is", url)
        if let urll = URL(string: url) {
            webView.browser.loadRequest(URLRequest(url: urll))
        } else {
            Alerts.showAlert(vc: self, title: "", message:"Can't open this url"){
                self.dismissMe()
            }
        }
        
        
    }
    
}


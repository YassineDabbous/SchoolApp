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
    
    public var url = Utils.server_url
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
        
        print("url is", url)
        let urll = URL(string: url)!
        webView.browser.loadRequest(URLRequest(url: urll))
        
    }
    
}


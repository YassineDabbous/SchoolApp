//
//  YOptions.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/15/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation
class YOptions: NSObject {
    
    var active:Bool = false
    var admob_activation:Bool = false
    var admob_interstitial_mode:Int = 0
    var admob_interstitial_clicks:Int = 0
    var admob_interstitial_pages:Int = 0
    var offline_mode:Bool = false
    var count:Int = 0
    var popup_per_day:Int = 0
    var image:String = ""
    var url:String = ""
    var time:Double = 0
    var app_version:Int = 0
    
    init(data:[String:Any]) {
        let a = data["active"] as! String
        let ac = data["admob_activation"] as! String
        let om = data["offline_mode"] as! String
        self.app_version = data["version"] as! Int
        self.count = data["count"] as! Int
        self.time = data["time"] as! Double
        self.image = data["image"] as! String
        self.url = (data["url"] as! String).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("YOptions url :) ",self.url)
        self.admob_interstitial_mode = data["admob_interstitial_mode"] as! Int
        self.admob_interstitial_clicks = data["admob_interstitial_clicks"] as! Int
        self.admob_interstitial_pages = data["admob_interstitial_pages"] as! Int
        self.popup_per_day = data["popup_per_day"] as! Int
        if ac == "1" {
            self.admob_activation = true
        }
        if a == "1" {
            self.active = true
        }
        if om == "1" {
            self.offline_mode = true
        }
        
        
        BaseViewController.admob_interstitial_mode = self.admob_interstitial_mode
        BaseViewController.admob_interstitial_clicks = self.admob_interstitial_clicks
        BaseViewController.admob_interstitial_pages = self.admob_interstitial_pages
    }
}


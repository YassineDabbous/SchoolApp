//
//  Utils.swift
//  Ekhdemni
//
//  Created by yassine dabbous on 3/13/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class Utils {
    
    public static let app_name:String = .localized(.app_name)
    public static var ads_after = 7
    public static let app_version = 5
    public static let app_id = "id1475668635"
    public static let app_link = "itunes.apple.com/app/"+Utils.app_id
    public static let email = "yassine.dabbous@gmail.com"
    
    static let appColor:UIColor = #colorLiteral(red: 0.1450980392, green: 0.8117647059, blue: 0.4, alpha: 1)
    static let appColorDark:UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    static let appColorAccent:UIColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    
    public static var ONESIGNAL_APP_KEY = "10da4098-2aad-405a-a741-3df2580a83f3"
    
    static var initialize:String = "ca-app-pub-7273575674375798~6400710487"
    static var interstitial:String = "ca-app-pub-7273575674375798/2049019044"
    static var banner:String = "ca-app-pub-7273575674375798/8235987593"
    
    /*static var initialize:String = "ca-app-pub-422494838­5649225/5754939730"
    static var interstitial:String = "ca-app-pub-422494838­5649225/5747486282"
    static var banner:String = "ca-app-pub-422494838­5649225/6491676027"*/
    
    /*// TEST
    static var initialize:String = "ca-app-pub-3940256099942544~1458002511"
    static var interstitial:String = "ca-app-pub-3940256099942544/4411468910"
    static var banner:String = "ca-app-pub-3940256099942544/2934735716"*/
    
    
    //${DEBUG_ACTIVITY_MODE}
    public static func print(_ vars:Any){
        Swift.print("\n", vars ,"\n")
    }
    
    public static let server_url = "https://uae-zad.com/"
    public static let url_privacy = "https://uae-zad.com/privacy-policy/"
    public static let url_contact = "https://uae-zad.com/اتصل-بنا/"
    
}



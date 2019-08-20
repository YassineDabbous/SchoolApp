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
    public static let app_version = 4
    public static let app_id = "id1475668635"
    public static let app_link = "itunes.apple.com/app/"+Utils.app_id
    public static let email = "yassine.dabbous@gmail.com"
    static let appColor:UIColor = #colorLiteral(red: 0.1450980392, green: 0.8117647059, blue: 0.4, alpha: 1)
    static let appColorDark:UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    static let appColorAccent:UIColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    public static var ONESIGNAL_APP_KEY = "10da4098-2aad-405a-a741-3df2580a83f3"
    static var initialize:String = "ca-app-pub-4224948385649225~8655988524"
    static var interstitial:String = "ca-app-pub-4224948385649225/3567313371"
    static var banner:String = "ca-app-pub-4224948385649225/5646681804"
    
    
    //${DEBUG_ACTIVITY_MODE}
    public static func print(_ vars:Any){
        Swift.print("\n", vars ,"\n")
    }
    
    public static let url_privacy = "https://uae-zad.com/­privacy-policy/"
    
    
    //public static let server_url = "http://hulul-q8.com/"
    public static let server_url = "http://www.school-q8.com/"
    public static let subjects = server_url+"api/"
    public static let subjectCategories = server_url+"api/cate.php?supjectID="
    public static let categoryChildren = server_url+"api/cate.php?cateID="
    public static let options_url = server_url+"api/optionsV3.php"
    public static let notifications_url = server_url+"api/notifications.php"
    public static let comments_url = server_url+"api/comments.php"
    public static let updates_url = server_url+"api/updates.php?time="
    public static let search_url = server_url+"api/search.php?q="
    public static let print_url = server_url+"print.php?id="
    public static let url_contact = server_url+"index#app"
    public static let book_url = server_url+"book.php?do=view&bookID="
    
}



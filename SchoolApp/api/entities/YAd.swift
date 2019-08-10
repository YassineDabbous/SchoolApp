//
//  YAd.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/14/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation

//http://api.uae-zad.com/public/api/v1/get_ads
struct Ad: Codable {
    let title: String?
    let img: String?
    var url:String = ""
}


//OLD
class YAd: NSObject {
    var id:String = ""
    var image:String = ""
    var url:String = ""
    
    init(data:[String:Any]) {
        //self.id = data["id"] as! String
        self.image = data["image"] as! String
        self.url = data["url"] as! String
    }
}

//
//  YFile.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/13/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation
class YFile : NSObject{
    var id:String = "0"
    var category:String = ""
    var subject:String = ""
    var title:String = ""
    var url:String = ""
    var marked:Bool = false
    
    override init() {
        super.init()
    }
    
    init(data:[String:Any], storing:Bool=true) {
        self.id = data["BookID"] as! String
        self.url = data["Url"] as! String
        self.category = data["CateID"] as! String
        self.subject = data["SupjectID"] as! String
        self.title = data["Name"] as! String
        /*let db:Db = Db()
        if storing {
            db.addFile(id: id, title: title, category: category, subject: subject, url: url)
        }*/
    }
    /*init(item:File) {
        self.id = item.id!
        self.category = item.category!
        self.subject = item.subject!
        self.url = item.url!
        self.title = item.title!
        self.marked = item.marked
    }*/
}

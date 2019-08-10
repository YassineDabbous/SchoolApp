//
//  YSubject.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/13/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation
class YSubject : NSObject{
    var id:String = ""
    var title:String = ""
    var count:String = ""
    var isUpdated:Bool = true
    
    init(data:[String:Any]) {
        self.id = data["SupjectID"] as! String
        self.title = data["Name"] as! String
        let c = data["count"] as! Int
        self.count = String(describing: c)
        //DB_FEATURE let db:Db = Db()
        //DB_FEATURE db.addSubject(title: title, id: id, count: count)
    }
    
}

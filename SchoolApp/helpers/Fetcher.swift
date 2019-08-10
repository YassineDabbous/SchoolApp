//
//  Fetcher.swift
//  Ekhdemni
//
//  Created by yassine dabbous on 3/18/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import Foundation
import Alamofire

class Fetcher: NSObject {
    

    //DB_FEATURE let db:Db = Db()
    let util:Utils = Utils()
    var array:[[String: Any]] = []
    
    func fetchUpdates(_ completion: @escaping ()  -> Void) {
        let defaults = UserDefaults.standard
        let last_check = defaults.integer(forKey: "last_check")
        print("fetch subjects from net => ", Date())
        fromNet(url:Utils.updates_url+"\(last_check)"){ (json: [String: Any]) in
            let time = json["time"] as! Int
            defaults.set(time, forKey: "last_check")
            let cats = json["categories"] as! [String]
            let subs = json["subjects"] as! [String]
            for id in cats {
                //DB_FEATURE self.db.updateCategory(id: id, keys: ["is_updated"], values: [false])
            }
            for id in subs {
                //DB_FEATURE self.db.updateSubject(id: id, keys: ["is_updated"], values: [false])
            }
            completion()
        }
    }
    
    
    /*
    func fetchNotifications(_ completion: @escaping (_ result: [YNotification])  -> Void) {
        print("fetch subjects from net => ", Date())
        fromNet(url:Utils.notifications_url){ (json: [String: Any]) in
            let array = json["data"] as! [[String: Any]]
            var items:[YNotification] = []
            for item in array {
                items.append(YNotification(data: item))
            }
            completion(items)
        }
    }
    */
    func fetchOptions(_ completion: @escaping (_ result: YOptions)  -> Void) {
        print("fetch options from net => ", Date())
        let defaults = UserDefaults.standard
        let old = defaults.double(forKey: "banner_time")
        let popNbr = defaults.integer(forKey: "popup_per_day")
        fromNet(url:Utils.options_url+"?os=ios&time=\(old)&nbr=\(popNbr)&v=\(Utils.app_version)"){ (json: [String: Any]) in
            let o = YOptions(data:json)
            completion(o)
        }
    }
    
    func fetchAds(_ completion: @escaping (_ result: [YAd])  -> Void) {
        print("fetch subjects from net => ", Date())
        fromNet(url:Utils.subjects){ (json: [String: Any]) in
            let array = json["ads"] as! [[String: Any]]
            var items:[YAd] = []
            for item in array {
                items.append(YAd(data: item))
            }
            completion(items)
        }
    }
    
    func fetchSubjects(_ completion: @escaping (_ result: [YSubject])  -> Void) {
        print("fetch subjects from db => ", Date())
        //let sdb = db.getSubjects(limit: 0, sort: [])
        if false  { //sdb.count > 0
            /*print("subjects from db are => ", sdb.count)
            var items:[YSubject] = []
            for item in sdb {
                items.append(YSubject(item: item))
            }
            completion(items)*/
        } else {
            print("fetch subjects from net => ", Date())
            fromNet(url:Utils.subjects){ (json: [String: Any]) in
                let array = json["data"] as! [[String: Any]]
                print("subjects from net are => ", array.count)
                var items:[YSubject] = []
                for item in array {
                    items.append(YSubject(data: item))
                }
                completion(items)
            }
        }
    }
    func fetchSubjectCategories(subject:YSubject, _ completion: @escaping (_ result: [YCategory])  -> Void) {
        /*print("fetch categories from db => ", Date())
        let sdb = db.getSubjectCategories(id:subject.id)
        if subject.isUpdated && sdb.count > 0 {
            print("Categories from db are => ", sdb.count)
            var items:[YCategory] = []
            for item in sdb {
                items.append(YCategory(item: item))
            }
            completion(items)
        } else {
            print("fetch categories from net => ", Date())
            fromNet(url:Utils.subjectCategories+subject.id){ (json: [String: Any]) in
                let array = json["data"] as! [[String: Any]]
                print("Categories from net are => ", array.count)
                var items:[YCategory] = []
                for item in array {
                    items.append(YCategory(data: item))
                }
                if !subject.isUpdated{
                    self.db.updateSubject(id: subject.id, keys: ["is_updated", "count"], values: [true, "\(array.count)"])
                }
                completion(items)
            }
        }*/
    }
    func fetchCategoryChildren(category:YCategory, _ completion: @escaping (_ result: MultiReturn)  -> Void) {
        /*print("fetch categories and files from db => ", Date())
        let sdb = db.getCategoryCategories(id: category.id)
        let r:MultiReturn = MultiReturn()
        if category.isUpdated && sdb.count > 0 {
            print("Categories from db are => ", sdb.count)
            var items:[YCategory] = []
            for item in sdb {
                items.append(YCategory(item: item))
            }
            r.cats = items
            completion(r)
        } else {
            let sdb = db.getCategoryFiles(id: category.id)
            if category.isUpdated && sdb.count > 0 {
                print("Files from db are => ", sdb.count)
                var items:[YFile] = []
                for item in sdb {
                    items.append(YFile(item: item))
                }
                r.books = items
                completion(r)
            } else {
                print("fetch categories and files from net => ", Date())
                fromNet(url:Utils.categoryChildren+category.id){ (json: [String: Any]) in
                    let array = json["data"] as! [[String: Any]]
                    let array2 = json["books"] as? [[String: Any]]
                    let array3 = json["videos"] as? [[String: Any]]
                    if array.count > 0 {
                        print("Categories from net are => ", array.count)
                        var items:[YCategory] = []
                        for item in array {
                            items.append(YCategory(data: item))
                        }
                        r.cats = items
                    }else if array2 != nil && array2!.count > 0 {
                        print("Files from net are => ", array2!.count)
                        var items:[YFile] = []
                        for item in array2! {
                            items.append(YFile(data: item))
                        }
                        r.books = items
                    }
                    if !category.isUpdated{
                        self.db.updateCategory(id: category.id, keys: ["is_updated", "count"], values: [true, "\(array.count)"])
                    }
                    completion(r)
                }
            }
        }*/
    }
    
    
    func fetchFiles(searchFor:String, _ completion: @escaping (_ result: [YFile])  -> Void) {
        print("fetch subjects from net => ", Date())
        fromNet(url: Utils.search_url+searchFor){ (json: [String: Any]) in
            let array = json["books"] as! [[String: Any]]
            var items:[YFile] = []
            for item in array {
                items.append(YFile(data: item, storing:false))
            }
            completion(items)
        }
    }



    func fromNet(url:String, _ completion: @escaping (_ result: [String: Any]) -> Void){
        print(url)
        let correctLink  = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: correctLink!)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch let error as NSError {
                print("errrrrrrrrrrrrrrrrrrrrrrrrror", error)
            }
        }).resume()
    }
    
}

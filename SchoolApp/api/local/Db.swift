//
//  Db.swift
//  SchoolApp
//
//  Created by yassine dabbous on 3/13/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import CoreData

class Db: NSObject {
    
    
    var files: [File] = []
    var updates: [NSManagedObject] = []
    
    
    
    func isSubjectExist(id:String) -> Bool {
        let predicate = NSPredicate(format: "id == %@", id)
        if getSubjects(whereClause: predicate, limit: 0, sort: []).count>0 {
            return true
        } else {
            return false
        }
    }
    func isCategoryExist(id:String) -> Bool {
        let predicate = NSPredicate(format: "id == %@", id)
        if getCategories(whereClause: predicate, limit: 0, sort: []).count>0 {
            return true
        } else {
            return false
        }
    }
    func isFileExist(id:String) -> Bool {
        let predicate = NSPredicate(format: "id == %@", id)
        if getFiles(whereClause: predicate, limit: 0, sort: []).count>0 {
            return true
        } else {
            return false
        }
    }
    
    func addFile(id:String, title:String, category:String, subject:String, url:String) {
        if !isFileExist(id: id){
            let keyValueList = [
                "id" : id,
                "title" : title,
                "category" : category,
                "subject" : subject,
                "url" : url,
                ] as [String : Any]
            save(table: "File", keyValueArray: keyValueList)
        }else {
            print("file", id, "exist")
        }
    }
    
    func addSubject(title:String, id:String, count:String) {
        if !isSubjectExist(id: id) {
            let keyValueList:[String:Any] = [
                "title" : title,
                "id" : id,
                "count" : count,
                "is_updated" : true
            ]
            save(table: "Subject", keyValueArray: keyValueList)
        }else {
            print("subject", id, "exist")
        }
    }
    func addCategory(id:String, title:String, category:String, subject:String, count:String) {
        if !isCategoryExist(id: id) {
            let keyValueList = [
                "id" : id,
                "title" : title,
                "category" : category,
                "subject" : subject,
                "count" : count,
                "is_updated" : true
                ] as [String : Any]
            save(table: "Category", keyValueArray: keyValueList)
        }else {
            print("category", id, "exist")
        }
    }
    
    
    
    
    func take(nbr:Int, after:Float) -> [File] {
        let predicate = NSPredicate(format: "id < %d", after)
        let sort = NSSortDescriptor(key: #keyPath(File.id), ascending: false)
        return getFiles(whereClause: predicate, limit: nbr, sort: [sort])
    }
    
    
    func getSubject(id:String) -> [Subject] {
        let predicate = NSPredicate(format: "id == %@", id)
        return getSubjects(whereClause: predicate, limit: 0, sort: [])
    }
    func getCategory(id:String) -> [Category] {
        let predicate = NSPredicate(format: "id == %@", id)
        return getCategories(whereClause: predicate, limit: 0, sort: [])
    }
    func getFile(id:String) -> [File] {
        let predicate = NSPredicate(format: "id == %@", id)
        return getFiles(whereClause: predicate, limit: 0, sort: [])
    }
    func getFilesByTitle(title:String) -> [File] {
        let predicate = NSPredicate(format: "title == %@", title)
        return getFiles(whereClause: predicate, limit: 0, sort: [])
    }
    
    func getSubjectFiles(subject:String) -> [File] {
        let predicate = NSPredicate(format: "subject == %@", subject)
        return getFiles(whereClause: predicate, limit: 0, sort: [])
    }
    
    func getCategorPosts(id:String) -> [File] {
        let predicate = NSPredicate(format: "category == %@", id)
        return getFiles(whereClause: predicate, limit: 0, sort: [])
    }
    
    
    func getMarkedFiles() -> [Post] {
        var y:[Post] = []
        let predicate = NSPredicate(format: "marked == %@", NSNumber(value: true))
        let fs = getFiles(whereClause: predicate, limit: 0, sort: [])
        for f in fs {
            y.append(Post(item: f))
        }
        return y
    }
    func getUnReadedFiles() -> [File] {
        let predicate = NSPredicate(format: "readed == %@", NSNumber(value: false))
        return getFiles(whereClause: predicate, limit: 0, sort: [])
    }
    func getLastReadedFiles() -> [Post] {
        var y:[Post] = []
        let predicate = NSPredicate(format: "readed == %@", NSNumber(value: true))
        let sort = NSSortDescriptor(key: #keyPath(File.readed_at), ascending: false)
        let fs = getFiles(whereClause: predicate, limit: 0, sort: [sort])
        for f in fs {
            y.append(Post(item: f))
        }
        return y
    }
    
    
    func getSubjectCategories(id:String) -> [Category] {
        let predicate = NSPredicate(format: "subject == %@", id)
        return getCategories(whereClause: predicate, limit: 0, sort: [])
    }
    func getCategoryCategories(id:String) -> [Category] {
        let predicate = NSPredicate(format: "category == %@", id)
        return getCategories(whereClause: predicate, limit: 0, sort: [])
    }
    
    
    
    ///update section
    func setFileAs(id:String, key:String, value:Bool) -> Bool {
        let fs = getFile(id:id)
        if fs.count >= 1 {
            return update(object: fs[0], key: key, value: value)
        } else {
            return false
        }
    }
    func setReadedAt(id:String) -> Bool {
        let fs = getFile(id:id)
        if fs.count >= 1 {
            update(object: fs[0], key: "readed", value: true)
            return update(object: fs[0], key: "readed_at", value: NSDate())
        } else {
            return false
        }
    }
    
    
    func updateSubject(id:String, keys:[String], values:[Any]) -> Bool {
        let fs = getSubject(id:id)
        if fs.count >= 1 {
            for (i,v) in keys.enumerated() {
                fs[0].setValue(values[i], forKey: keys[i])
            }
            return update(object: fs[0])
        } else {
            return false
        }
    }
    func updateCategory(id:String, keys:[String], values:[Any]) -> Bool {
        let fs = getCategory(id:id)
        if fs.count >= 1 {
            for (i,v) in keys.enumerated() {
                fs[0].setValue(values[i], forKey: keys[i])
            }
            return update(object: fs[0])
        } else {
            return false
        }
    }
    
    // -------------- general ------------
    func getFiles(whereClause:NSPredicate? = nil, limit:Int, sort:[NSSortDescriptor]) -> [File] {
        return select(from:"File", whereClause:whereClause, limit:limit, sort:sort) as! [File]
    }
    func getSubjects(whereClause:NSPredicate? = nil, limit:Int, sort:[NSSortDescriptor]) ->  [Subject] {
        return select(from:"Subject", whereClause:whereClause, limit:limit, sort:sort) as! [Subject]
    }
    func getCategories(whereClause:NSPredicate? = nil, limit:Int, sort:[NSSortDescriptor]) ->  [Category] {
        return select(from:"Category", whereClause:whereClause, limit:limit, sort:sort) as! [Category]
    }
    func select(from:String, whereClause:NSPredicate? = nil, limit:Int, sort:[NSSortDescriptor]) -> [NSManagedObject] {
        var anyList:[NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: from)
        
        //let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate2])
        if(whereClause != nil){
            fetchRequest.predicate = whereClause
        }
        if(limit>0){
            fetchRequest.fetchLimit = limit
        }
        if(sort.count>0){
            fetchRequest.sortDescriptors = sort
        }
        do {
            anyList = try managedContext.fetch(fetchRequest) as [NSManagedObject]
        } catch let error as NSError {
            print("db db db errorrrr Could not fetch. \(error), \(error.userInfo)")
        }
        return anyList
    }
    func save(table:String, keyValueArray:[String : Any]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: table, in: managedContext)!
        let t = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for (e, value) in keyValueArray{
            t.setValue(value, forKeyPath:e)
        }
        
        do {
            try managedContext.save()
            print("................. \(table) saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func update(object:NSManagedObject, key:String, value:Any) -> Bool {
        object.setValue(value, forKey: key)
        return update(object:object)
    }
    func update(object:NSManagedObject) -> Bool {
        do {
            try object.managedObjectContext?.save()
            return true
        } catch {
            let saveError = error as NSError
            print(saveError)
            return false
        }
    }
    
    
    func delete(object:NSManagedObject) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(object)
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error)
        }
        return true
    }
    
    func delete(from:String, whereClause:NSPredicate) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: from)
        fetchRequest.predicate = whereClause
        
        do {
            let files:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            for file in files{
                managedContext.delete(file)
            }
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return true
    }
    func destroy() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch1        = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        let fetch2        = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let fetch3        = NSFetchRequest<NSFetchRequestResult>(entityName: "File")
        let request1      = NSBatchDeleteRequest(fetchRequest: fetch1)
        let request2      = NSBatchDeleteRequest(fetchRequest: fetch2)
        let request3      = NSBatchDeleteRequest(fetchRequest: fetch3)
        do {
            let result1       = try managedContext.execute(request1)
            let result2       = try managedContext.execute(request2)
            let result3       = try managedContext.execute(request3)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return true
    }
    
}


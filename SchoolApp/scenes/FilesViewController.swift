//
//  FilesViewController.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/12/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Kingfisher

class FilesViewController: WithGenericTableView<BookCell, Post> {
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    var tableView:UITableView!
    var headerView:HeaderView!
    
    public var category:YCategory?
    
    public var searchFor:String = ""
    //DB_FEATURE public var db:Db = Db()
    override func loadView() {
        super.loadView()
        
        print("loadViewwwwwwwwwwwwwwww")
        
        drawMainView()
        
        headerView = HeaderView()
        self.main.addSubview(headerView)
        headerView.anchor(top: main.topAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor,
                          padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
                          size: CGSize(width: 0, height: 40))
        
        tableView = UITableView(frame: .zero)
        self.main.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, leading: main.leadingAnchor,
                         bottom: main.bottomAnchor, trailing: main.trailingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 50, right: 4))
        
        
        print("viewwwwwwwwwwwwww loaded")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(.Files)
        
        tableView.backgroundColor = .white
        initTable(&tableView)
        refreshData()
    }
    
    override func refreshData() {
        self.showIndicator()
        print("searchFor =", searchFor)
        print("category =", category)
        if let category = category {
            headerView.titleView.text = category.name
            self.perform(APIClient.getPosts(id: category.id!)){ success, data in
                self.hideIndicator()
                if let d = data {
                    self.items = d
                    self.tableView.animateTable()
                }
            }
        }else if searchFor.elementsEqual("marked") {
            //DB_FEATURE items = db.getMarkedFiles()
            headerView.titleView.text = "المفضلة"
        }else if searchFor.elementsEqual("last_readed") {
            //DB_FEATURE items = db.getLastReadedFiles()
            headerView.titleView.text = "ملفات قرأتها"
        }else if searchFor != "" {
            headerView.titleView.text = "بحث عن "+self.searchFor
            self.perform(APIClient.search(word: searchFor)){ success, data in
                self.hideIndicator()
                if let d = data {
                    self.items = d
                    self.tableView.animateTable()
                }
            }
        }
    }
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: Post?) {
        print(model?.postTitle)
        router.document(file: model!)
    }
}
//        let item:YSubject = items[indexPath.row]
extension FilesViewController {
    /*func tablesView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = self.items.count
        return s + (s / Utils.ads_after)
    }
    
    func tablesView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= Utils.ads_after && (indexPath.row % Utils.ads_after) == 0 {
            return tableView.getAdmobCell(root: self)
        }else{
            var position = indexPath.row
            if position >= Utils.ads_after {
                position = position - (position/Utils.ads_after)
            }
            let cell:BookCell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
            let item = self.items[position]
            cell.backgroundColor = UIColor.clear
            cell.titleView.text = item.title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt", indexPath.row)
        if indexPath.row >= Utils.ads_after && (indexPath.row % Utils.ads_after) == 0 {
            print("not a data cell")
        }else{
            performSegue(withIdentifier: "toDocument", sender: indexPath)
        }
    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDocument"{
            let vc = segue.destination as! DocumentViewController
            let indexPath = sender as! IndexPath
            print(indexPath.row)
            var position = indexPath.row
            if position >= Utils.ads_after {
                position = position - (position/Utils.ads_after)
            }
            vc.file = self.items![position]
        }
    }
    
}

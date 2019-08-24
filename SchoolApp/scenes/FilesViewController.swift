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
    
    override func loadView() {
        super.loadView()
        
        
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
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
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

//
//  BaseTableViewSearchController.swift
//  MyApp
//
//  Created by X on 4/20/19.
//  Copyright © 2019 X. All rights reserved.
//


import UIKit

class BaseTableViewSearchController<T: GenericTableViewCell<V>, V>: UITableViewController, UISearchBarDelegate where V: Searchable {
    
    private var strongDataSource: GenericTableViewDataSource<V, T>?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var models: [V] = [] {
        didSet {
            DispatchQueue.main.async {
                self.strongDataSource = GenericTableViewDataSource(models: self.models)
                self.tableView.dataSource = self.strongDataSource
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("* register")
        tableView.register(T.self)
        print("* registered")
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
        }
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        strongDataSource?.search(query: searchText)
        self.tableView.reloadData()
    }
}

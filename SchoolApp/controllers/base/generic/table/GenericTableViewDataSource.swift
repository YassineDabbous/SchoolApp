//
//  GenericTableViewDataSource.swift
//  MyApp
//
//  Created by X on 4/20/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

final class GenericTableViewDataSource<T:Searchable, V:GenericTableViewCell<T>>: NSObject, UITableViewDataSource {
    
    private var models: [T]
    
    private var searchResults: [T] = []
    private var isSearchActive: Bool = false
    
    init(models: [T]) {
        self.models = models
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? searchResults.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: V = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.item = getModelAt(indexPath)
        return cell
    }
    
    private func getModelAt(_ indexPath: IndexPath) -> T {
        return isSearchActive ? searchResults[indexPath.item] :  models[indexPath.item]
    }
    
    /// external function for searching
    func search(query: String) {
        isSearchActive = !query.isEmpty
        searchResults = models.filter {
            let queryToFind = $0.query.range(of: query, options: NSString.CompareOptions.caseInsensitive)
            return (queryToFind != nil)
        }
    }
}

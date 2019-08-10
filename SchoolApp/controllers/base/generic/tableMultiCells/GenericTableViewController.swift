//
//  GenericTableViewController.swift
//  MyApp
//
//  Created by X on 4/20/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class GenericTableViewController<T: DescriptiveProtocol>: UITableViewController {
    
    var didSelect: (T) -> () = { _ in }
    private var source: [T] = [T]()
    var dismissable = false
    
    init(source: [T], title: String, dismissOnClick dismiss:Bool = false) {
        self.source = source
        super.init(style: .plain)
        self.title = title
        self.tableView.tableFooterView = UIView()
        self.dismissable = dismiss
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    
    private func register() {
        let uniqueList = Set(source.compactMap({$0.descriptor.reuseIdentifier}))
        uniqueList.forEach({
            tableView.register($0.descriptor.cellClass, forCellReuseIdentifier: $0.descriptor.reuseIdentifier)
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let descriptor = source[indexPath.row].descriptor
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath) as! DropDownCell
        cell.onAction = { (_, action) -> () in
            self.didSelect(self.source[indexPath.row])
            print("oooo :D")
            self.dismiss()
        }
        descriptor.configure(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = source[indexPath.row]
        dismiss()
        didSelect(item)
    }
    func dismiss(){
        if dismissable {
            print("disssssssmissssss")
            dismissMe()
        }
    }
}

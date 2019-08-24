//
//  WithGenericTableView.swift
//  MyApp
//
//  Created by X on 4/25/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

enum TableCells {
    case one
    case two
}

class WithGenericTableView<CELL: GenericTableViewCell<MODEL>, MODEL>: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cv:UITableView?
    
    private var layoutOption: TableCells = .one
    
    var items:[MODEL]? {
        didSet {
            print("items count", items?.count as Any)
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight > 0 ? tableView.estimatedRowHeight : 40
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initTable(_ tableView:inout UITableView, _ estimatedRowHeight:CGFloat){
        initTable(&tableView)
        cv?.rowHeight = UITableView.automaticDimension
        cv?.estimatedRowHeight = estimatedRowHeight
    }
    func initTable(_ tableView:inout UITableView){
        cv = tableView
        cv?.dataSource = self
        cv?.delegate = self
        cv?.keyboardDismissMode = .onDrag // .interactive
        setupTableView()
    }
    
    
    open func setupTableView() {
        //cv?.register(UINib(nibName: CELL.nibName, bundle: nil), forCellWithReuseIdentifier: CELL.reuseIdentifier)
        cv?.register(UITableViewCell.self, forCellReuseIdentifier: "AdViewCell")
        cv?.register(CELL.self, forCellReuseIdentifier: CELL.reuseIdentifier)
        //cv?.register(CELL2.self, forCellReuseIdentifier: CELL2.reuseIdentifier)
        
        addRefreshControl()
    }
    
    
    // overrride this function
    func onInteract(_ indexPath:IndexPath, _ action:Action, _ model:MODEL?){
        print("on interact parent called")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt call onInteract", indexPath.row)
        self.onInteract(indexPath, Action.show, items?[indexPath.row] )
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("generic table items count", items?.count )
        if (items?.count ?? 0) == 0 {
            cv?.emptyMessage(message: .localized(.EmptyData))
        } else {
            cv?.emptyMessage(hide: true)
        }
        let s = items?.count ?? 0
        if supportAds {
            return s + (s / Utils.ads_after)
        } else {
            return s
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if supportAds && indexPath.row >= Utils.ads_after && (indexPath.row % Utils.ads_after) == 0 {
            return tableView.getAdmobCell(root: self)
        }else{
            var position = indexPath.row
            if supportAds && position >= Utils.ads_after {
                position = position - (position/Utils.ads_after)
            }
            let cell:CELL = tableView.dequeueReusableCell(withIdentifier: CELL.reuseIdentifier, for: indexPath) as! CELL
            guard let model = items?[position] else {
                print("model is nil, return empty cell")
                return cell
            }
            cell.item = model
            cell.onAction = { (model, action) -> () in
                self.onInteract(indexPath, action, model)
            }
            return cell
        }
    }
    
    /*func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }*/
    
    var headerTitle : String?
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if headerTitle != nil {
            return 40.0
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = headerTitle else {
            return nil
        }
        let view = UIView()//ListViewHeader()
        /*view.item = title
        view.onAction = { (model, action) -> () in
            self.onInteract(IndexPath(row: 0, section: section), action, nil)
            print("ooooo", action)
        }*/
        return view
    }
    
    
    
    override func onResponseHandled(_ success: Bool) {
        super.onResponseHandled(success)
        print("Success \(success) handled in child generic")
        refreshControl?.endRefreshing()
    }
    
    
    /**
     ** Adding Refresh Control
     **/
    private var refreshControl:UIRefreshControl?
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            cv?.refreshControl = refreshControl
        } else if refreshControl != nil {
            cv?.addSubview(refreshControl!)
        }
        refreshControl?.addTarget(self, action: #selector(requestNewData(_:)), for: .valueChanged)
        refreshControl?.tintColor = Utils.appColor
        refreshControl?.attributedTitle = NSAttributedString(string: .localized(.FetchingNewData))
    }
    @objc private func requestNewData(_ sender: Any) {
        refreshData()
    }
    open func refreshData() {
        reloadData()
    }
    func reloadData(){
        cv?.reloadData()
        refreshControl?.endRefreshing()
    }
    
}

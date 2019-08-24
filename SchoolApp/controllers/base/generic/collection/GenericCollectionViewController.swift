//
//  GenericCollectionViewController.swift
//  MyApp
//
//  Created by X on 4/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

enum LayoutOption {
    case list
    case smallGrid
    case largeGrid
}

class GenericCollectionViewController<CELL: GenericCollectionViewCell<MODEL>, CELL2: GenericCollectionViewCell<MODEL>, MODEL>: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var cv:UICollectionView?
    
    var list_item_height = CGFloat(50)
    var grid_item_height = 150
    var layoutOption: LayoutOption = .list
    
    var items:[MODEL]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initCollection(_ collectionView:inout UICollectionView){
        cv = collectionView
        cv?.keyboardDismissMode = .onDrag // .interactive
        cv?.dataSource = self
        cv?.delegate = self
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupLayout(with: size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayout(with: view.bounds.size)
    }
    
    open func setupCollectionView() {
        //cv?.register(UINib(nibName: CELL.nibName, bundle: nil), forCellWithReuseIdentifier: CELL.reuseIdentifier)
        cv?.register(CELL.self, forCellWithReuseIdentifier: CELL.reuseIdentifier)
        cv?.register(CELL2.self, forCellWithReuseIdentifier: CELL2.reuseIdentifier)
        cv?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AdViewCell")
        addRefreshControl()
    }

    
    
     func setupLayout(with containerSize: CGSize) {
        print("collection container size", containerSize)
        guard let flowLayout = cv?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        switch layoutOption {
        case .list:
            
            flowLayout.itemSize = CGSize(width: containerSize.width, height: list_item_height)
            
            /*flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 8.0, right: 0)
            
            if traitCollection.horizontalSizeClass == .regular {
                let minItemWidth: CGFloat = 300
                let numberOfCell = containerSize.width / minItemWidth
                let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
                flowLayout.itemSize = CGSize(width: width, height: 130)
            } else {
                flowLayout.itemSize = CGSize(width: containerSize.width, height: list_item_height)
            }*/
            
        case .largeGrid, .smallGrid:
            //return CGSize(width: 185.0, height: 250)
            var minItemWidth: CGFloat! // = containerSize.width / 2 - 10
            if layoutOption == .smallGrid {
                minItemWidth = 106
            } else {
                minItemWidth = 150
            }
            
            
            let numberOfCell = containerSize.width / minItemWidth
            let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
            let height = ceil(width * (4.0 / 2.4))
            
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: width, height: height)
            flowLayout.sectionInset = .zero
            
            print("new items size", flowLayout.itemSize)
        }
        
        cv?.reloadData()
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        switch layoutOption {
            case .list:
                return CGSize(width: width, height: 120)
        case .largeGrid, .smallGrid:
                return CGSize(width: (width - 15)/2, height: (width - 15)/2)
        }
    }*/
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("shouldSelectItemAt called", indexPath)
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt called", indexPath)
        self.onInteract(indexPath, Action.show, items?[indexPath.row] )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("generic collection items count", items?.count )
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if supportAds && indexPath.row >= Utils.ads_after && (indexPath.row % Utils.ads_after) == 0 {
            return collectionView.getAdmobCell(self, indexPath:indexPath)
        }else{
            var position = indexPath.row
            if supportAds && position >= Utils.ads_after {
                position = position - (position/Utils.ads_after)
            }
            let cell:GenericCollectionViewCell<MODEL>?
            switch layoutOption {
            case .largeGrid, .smallGrid:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL2.reuseIdentifier, for: indexPath) as? CELL2
            default:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL.reuseIdentifier, for: indexPath) as? CELL
            }
            guard let model = items?[position] else { return cell! }
            cell!.item = model
            cell!.onAction = { (model, action) -> () in
                self.onInteract(collectionView, indexPath, action, model)
                self.onInteract(indexPath, action, model)
            }
            return cell!
        }
    }
    
    
    func onInteract(_ collectionView: UICollectionView, _ indexPath:IndexPath, _ action:Action, _ model:MODEL?){
        
    }
    func onInteract(_ indexPath:IndexPath, _ action:Action, _ model:MODEL?){
        print("parent on interact closure called", action)
        /*switch action {
            case .addToCart:
                self.addToCart(model)
            case .addToWishlist:
                self.addToWishlist(model)
            default:
                print("action unkenowen", action )
        }*/
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
    }
    func reloadData(){
        cv?.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    override func onResponseHandled(_ success: Bool) {
        super.onResponseHandled(success)
        print("Success \(success) handled in child generic")
        refreshControl?.endRefreshing()
    }
    
    
    
    
    
    
    
    /**
     ** ANIMATION
     **/
    func deleteWithAnimation(indexs:[IndexPath]){
        for indexPath in indexs {
            self.items?.remove(at: indexPath.row)
        }
        self.cv?.performBatchUpdates({
            //UIView.setAnimationsEnabled(false)
            self.cv?.deleteItems(at: indexs)
            
        }, completion: { [unowned self] (_) in
            //
            //
            //UIView.setAnimationsEnabled(true)
        })
    }
    
}

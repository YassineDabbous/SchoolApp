//
//  ViewController.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/5/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Kingfisher

typealias GenericCollection = GenericCollectionViewController<ListCategoryCell, GridCategoryCell, YCategory>

class CategororiesViewController: GenericCollection , UITextFieldDelegate {
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    var search:SearchView = SearchView()
    var myCollectionView:UICollectionView!
    
    public static var ads:[YAd] = []
    var category:YCategory?
    let utils:Utils = Utils()
    
    
    func searchFiles() {
        increasePages()
        router.search(word: self.search.searchInput.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        self.searchFiles()
        return true
    }
    @objc public func searchMe(gesture: UITapGestureRecognizer){
        self.searchFiles()
    }
    
    
    
    
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        search = SearchView()
        self.main.addSubview(search)
        search.anchor(top: main.topAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor,
                      padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
                      size: CGSize(width: 0, height: 40))
        
        
        
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //myCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        myCollectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.main.addSubview(myCollectionView)
        myCollectionView.anchor(top: search.bottomAnchor, leading: main.leadingAnchor,
                                bottom: main.bottomAnchor, trailing: main.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0))
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isInitial = true
        navigationItem.title = "Categories"
        main.backgroundColor = .white
        search.backgroundColor = .white
        myCollectionView.backgroundColor = .white
        
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(self.searchMe))
        search.searchImage.addGestureRecognizer(tapSearch)
        search.searchImage.isUserInteractionEnabled = true
        search.searchInput.delegate = self
        
        
        
        //layoutOption = .largeGrid
        initCollection(&myCollectionView)
        
        //self.view.layoutIfNeeded()
        //setupLayout(with: myCollectionView.bounds.size)
        //print("show as", layoutOption)
        
        refreshData()
        
        /*fetcher.fetchUpdates(){
            
            self.fetcher.fetchSubjects(){ (result: [YSubject]) in
                self.items = result
                self.myCollectionView.reloadData()
                self.view.setNeedsLayout()
            }
        }*/
        
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "admob_activation") {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            addBannerViewToView(bannerView)
            bannerView.adUnitID = Utils.banner
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
    }
    
    func needUpdate(){
        Alerts.showAlert(vc: self, title: "تحديث", message: "يجب تحديث التطبيق للإصدار الجديد !") { () in
            AppHelper.rateApp(){ success in
                print("RateApp \(success)")
            }
        }
    }
    
    override func refreshData() {
        if let category = category {
            self.perform(APIClient.getSubCategories(id: category.id!)){ success, data in
                if let d = data {
                    self.items = d
                    self.myCollectionView.reloadData()
                    self.view.setNeedsLayout()
                }
            }
        } else {
            self.perform(APIClient.getCategories()){ success, data in
                if let d = data {
                    self.items = d
                    self.myCollectionView.reloadData()
                    self.view.setNeedsLayout()
                }
            }
        }
    }
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: YCategory?) {
        increasePages()
        print("select position", indexPath.row, "item is", model?.id, "=>", model?.name)
        if model!.childNumber! > 0 {
            self.router.categories(category: model!)
        } else {
            self.router.files(category: model!)
        }
    }
}

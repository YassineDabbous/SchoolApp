//
//  ViewController.swift
//  MyApp
//
//  Created by X on 4/8/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import PromiseKit.PromiseKit
/*
class ViewController0: BaseViewController {
    
    lazy var router:HomeRouter = HomeRouter(viewController: self)
    
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var manufacturersCollection: UICollectionView!
    //@IBOutlet weak var manufacturersCollection: UICollectionView!
    //@IBOutlet weak var productsCollection: UICollectionView!
    //@IBOutlet weak var slider: UIScrollView!
    @IBOutlet weak var slider: UIScrollView!
    @IBOutlet weak var dots: UIPageControl!
    //@IBOutlet weak var dots: UIPageControl!
    var banners:[Banner] = [] {
        didSet{
            bindSlider()
        }
    }
    var manufacturers:[Manufacturer] = [] {
        didSet{
            manufacturersCollection.reloadData()
        }
    }
    var products:[ListProductsModels.ProductViewModel] = [] {
        didSet{
            productsCollection.reloadData()
            setScroller()
        }
    }
    
    
    @IBOutlet weak var productsHeight: NSLayoutConstraint!
    
    func setScroller(){
       /* var frame = productsCollection.frame
        frame.size.height = productsCollection.contentSize.height
        productsCollection.frame = frame*/
        let h = CGFloat(products.count * 140) // self.view.bounds.height //productsCollection.contentSize.height
        print("table height -_-_-_- ", h)
        productsHeight.constant = h
        productsCollection.layoutIfNeeded()
        //productsCollection.isScrollEnabled = false // this will disable detecting clicks too
        scroller.fitToSize(of: card)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showIndicator()
        
        prepareCollections()
        perform(APIClient.getSlideshows()){ success, data in
            if let d = data {
                if d.count > 0 {
                    self.banners = d[0].banners ?? []
                }
            }
        }
        
        perform(APIClient.getManufacturers()){ success, data in
            if let d = data {
                self.manufacturers = d
            }
        }
        
        
        perform(APIClient.getProducts()){ success, data in
            if let d = data {
                var itms : [ListProductsModels.ProductViewModel] = []
                for i in d {
                    itms.append(ListProductsModels.ProductViewModel.from(i))
                }
                self.products = itms
            }
            self.hideIndicator()
        }
        
        perform(APIClient.cart()){ success, data in
            if let d = data {
                MainViewController.cartCount = d.totalProductCount
            }
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        isInitial = true
        super.viewWillAppear(animated)
    }
    
}
extension ViewController : UIScrollViewDelegate{
    func bindSlider(){
        dots.numberOfPages = banners.count
        slider.delegate = self
        slider.contentSize = CGSize(width: view.frame.width * CGFloat(banners.count), height: 180.0)
        slider.isPagingEnabled = true
        for (index, item) in banners.enumerated() {
            if let view:SliderItem = Bundle.main.loadNibNamed("SliderItem", owner: self, options: nil)?.first as? SliderItem {
                let url = URL(string: item.image!)
                view.image.kf.setImage(with: url)
                
                view.frame = CGRect(x: (CGFloat(index) * self.view.frame.size.width), y: 0, width: slider.frame.width, height: slider.frame.height)
                view.tag = index
                slider.addSubview(view)
            }
        }
        view.bringSubviewToFront(dots)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        dots.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
 
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }*/
    }
}




fileprivate enum collexion:Int{
    case manufacturers = 0
    case products = 1
}
extension ViewController : UICollectionViewDataSource{
    
    func prepareCollections(){
        manufacturersCollection.dataSource = self
        manufacturersCollection.delegate = self
        manufacturersCollection.tag = collexion.manufacturers.rawValue
        
        productsCollection.backgroundColor = UIColor.white
        productsCollection.dataSource = self
        productsCollection.delegate = self
        productsCollection.tag = collexion.products.rawValue
        manufacturersCollection.register(ManufacturerCell.self, forCellWithReuseIdentifier: ManufacturerCell.reuseIdentifier)
        productsCollection.register(ProductView.self, forCellWithReuseIdentifier: ProductView.reuseIdentifier)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case collexion.manufacturers.rawValue:
            print("manufacturers count:", self.manufacturers.count as Any)
            return self.manufacturers.count
        default:
            print("products count:", self.products.count as Any)
            return self.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("index is", indexPath.row)
        switch collectionView.tag {
            case collexion.manufacturers.rawValue:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManufacturerCell.reuseIdentifier, for: indexPath) as! ManufacturerCell
                cell.item = manufacturers[indexPath.row]
                cell.onAction = { (model, action) -> () in
                    self.onManufacturerInteract(indexPath, action, model)
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductView.reuseIdentifier, for: indexPath) as! ProductView
                cell.item = products[indexPath.row]
                cell.onAction = { (model, action) -> () in
                    self.onProductInteract(indexPath, action, model)
                }
                return cell
        }
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case collexion.manufacturers.rawValue:
            return CGSize(width: 100, height: 100)
        default:
            return CGSize(width: self.view.frame.width, height: 130)
        }
    }
}
extension ViewController:UICollectionViewDelegate{}
extension ViewController{
    
    func onProductInteract(_ indexPath: IndexPath, _ action: Action, _ model: ListProductsModels.ProductViewModel?) {
        print("chiled on interact closure called", action)
        switch action {
        case .show:
            router.product(id: model!.id)
        case .addToCart:
            self.addToCart(model!)
        case .addToWishlist:
            self.addToWishlist(model!)
        default:
            print("action unkenowen", action )
        }
    }
    func onManufacturerInteract(_ indexPath: IndexPath, _ action: Action, _ model: Manufacturer?) {
        print("chiled on interact closure called", action)
        router.manufacturer(item: model!)
    }
}

extension ViewController{
    
    func update(_ m:ListProductsModels.ProductViewModel){
        let i = self.products.firstIndex{ $0.id == m.id}
        guard let index = i else { return }
        self.products[index] = m
        productsCollection.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func addToCart(_ model:ListProductsModels.ProductViewModel){
        if !model.inCart {
            perform(APIClient.cartAddItem(request: CartAddRequest(productID: "\(model.id)", quantity: "1", option: [:]))){ success, data in
                if let d = data {
                    MainViewController.cartCount = d.totalProductCount
                }
                print("addToCart done")
                var m = model
                m.inCart = !m.inCart
                self.update(m)
            }
        }else{
            perform(APIClient.cartRemoveItem(request: CartDeleteRequest(key: "\(model.id)"))){ success, data in
                print("addToCart done")
                var m = model
                m.inCart = !m.inCart
                self.update(m)
            }
        }
    }
    func addToWishlist(_ model:ListProductsModels.ProductViewModel){
        if !model.liked {
            perform(APIClient.wishlistAddItem(id: model.id)){ success, data in
                print("addToWishlist done")
                var m = model
                m.liked = !m.liked
                self.update(m)
            }
        }else{
            perform(APIClient.wishlistRemoveItem(id: model.id)){ success, data in
                print("addToWishlist done")
                var m = model
                m.liked = !m.liked
                self.update(m)
            }
        }
    }
}




*/

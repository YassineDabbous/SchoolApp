//
//  BaseViewController.swift
//  MobilyStore
//
//  Created by yassine dabbous on 2/4/19.
//  Copyright © 2019 yassine dabbous. All rights reserved.
//


import UIKit
import GoogleMobileAds

class BaseViewController: MainViewController {
    
    
    var main: UIView = UIView(frame: .zero)
    var scrollView : UIScrollView!
    var isScrollable = false
    func drawMainView(scroller : UIScrollView? = nil){
        // This will fix the view from being framed underneath the navigation bar and status bar.
        self.navigationController?.navigationBar.isTranslucent = false
        
        if(isScrollable){
            if scroller==nil{
                scrollView = UIScrollView(frame: .zero)
                self.view.addSubview(scrollView)
                 scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            } else {
                scrollView = scroller
            }
            
            /*self.scroller.addSubview(main)
            main.anchor(top: scroller.topAnchor, leading: scroller.leadingAnchor, trailing: scroller.trailingAnchor)*/
            main.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(main)
            main.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            main.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            main.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            main.heightAnchor.constraint(equalToConstant: 1000).isActive = true
            let bottomMostView = UIView(frame: .zero)
            //scrollView.backgroundColor = .yellow
            bottomMostView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(bottomMostView)
            bottomMostView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            bottomMostView.topAnchor.constraint(equalTo: main.bottomAnchor).isActive = true
            bottomMostView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bottomMostView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            bottomMostView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        } else {
            self.view.addSubview(main)
            main.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        }
        main.addDashedBorder()
    }
    func fitScroller(){
        
        
        scrollView.fitToSize(of: main)
        
        print("size for main realSizee ", main.realSize())
        print("size for main sizee", main.frame.size)
        print("size for main intrinsicContentSize", main.intrinsicContentSize)
        print("size for scroller ", scrollView.contentSize)
    }
    
    
    // proprieties
    public static var interstitialView: GADInterstitial!
    var bannerView: GADBannerView!
    
    public static var admob_interstitial_mode:Int = 0;
    public static var admob_interstitial_clicks_current_count:Int = 0;
    public static var admob_interstitial_pages_current_count:Int = 0;
    public static var admob_interstitial_last_count:Int = 0;
    public static var admob_interstitial_pages:Int = 3;
    public static var admob_interstitial_clicks:Int = 6;

    func safeArea() -> UILayoutGuide {
        if #available(iOS 11.0, *) {
            return view!.safeAreaLayoutGuide
        } else {
            return view!.layoutMarginsGuide
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.moveWithKeyboard()
        self.hideKeyboardWhenTappedAround()
        
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "admob_activation") {
            if BaseViewController.interstitialView == nil {
                createAd()
            }
            showInterstitial()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.view.endEditing(true)
    }
    
    // <Loader>
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
    func showIndicator() {
        showIndicator(.localized(.msgWait))
    }
    func hideIndicator(){
        self.effectView.removeFromSuperview()
    }
    func showIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        print("------ System Language: ", Locale.current.languageCode)
        if Locale.current.languageCode == "ar" {
            strLabel = UILabel(frame: CGRect(x: -10, y: 0, width: 160, height: 46))
        } else {
            strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        }
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.2, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    
    // </Loader>
    
    
    
    
    
    
}

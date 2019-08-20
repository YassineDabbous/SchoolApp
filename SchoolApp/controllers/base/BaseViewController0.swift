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
    
    
    func safeArea() -> UILayoutGuide {
        if #available(iOS 11.0, *) {
            return view!.safeAreaLayoutGuide
        } else {
            return view!.layoutMarginsGuide
        }
    }
    
    func drawMainView(scroller : UIScrollView? = nil){
        // This will fix the view from being framed underneath the navigation bar and status bar.
        self.navigationController?.navigationBar.isTranslucent = false
        
        if(isScrollable){
            if scroller==nil{
                scrollView = UIScrollView(frame: .zero)
                self.view.addSubview(scrollView)
                 scrollView.fill(parent: view)
            } else {
                scrollView = scroller
            }
            
            scrollView.setAsContentView(&main)
            
        } else {
            self.view.addSubview(main)
            main.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: (supportAds ? 52 : 4), right: 4))
        }
    }
    func fitScroller(){
        
        
        print("size for main realSizee ", main.realSize())
        print("size for main sizee", main.frame.size)
        print("size for main intrinsicContentSize", main.intrinsicContentSize)
        print("size for scroller ", scrollView.contentSize)
        
        scrollView.fitToSize(of: main)
        view.layoutIfNeeded()
        
        print("size for main realSizee ", main.realSize())
        print("size for main sizee", main.frame.size)
        print("size for main intrinsicContentSize", main.intrinsicContentSize)
        print("size for scroller ", scrollView.contentSize)
    }
    
    
    // proprieties
    var supportAds = true
    public static var interstitialView: GADInterstitial!
    var bannerView: GADBannerView!
    
    public static var admob_interstitial_mode:Int = 0;
    public static var admob_interstitial_clicks_current_count:Int = 0;
    public static var admob_interstitial_pages_current_count:Int = 0;
    public static var admob_interstitial_last_count:Int = 0;
    public static var admob_interstitial_pages:Int = 3;
    public static var admob_interstitial_clicks:Int = 6;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.moveWithKeyboard()
        self.hideKeyboardWhenTappedAround()
        
        //UserDefaults.standard.set(true, forKey: "admob_activation")
        //let defaults = UserDefaults.standard
        if supportAds { //defaults.bool(forKey: "admob_activation")
            if BaseViewController.interstitialView == nil {
                createAd()
            }
            showInterstitial()
            showBannerAd()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isHidden = false // to Solve Nested Window problem (previous vc appear behind the new one)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.isHidden = true // to Solve Nested Window problem (previous vc appear behind the new one)
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

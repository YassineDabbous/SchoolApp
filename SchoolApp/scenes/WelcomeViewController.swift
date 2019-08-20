//
//  WelcomeViewController.swift
//  SchoolApp
//
//  Created by X on 7/16/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
//import MaterialShowcase

class WelcomeViewController: BaseViewController {
    
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    let titleView:UILabel = {
        let tv = LabelBold()
        tv.textAlignment = .center
        tv.text = "مرحبا"
        return tv
    }()
    let descriptionView:UILabel = {
        let tv = LabelBold()
        tv.textAlignment = .center
        tv.numberOfLines = 0
        tv.text = "نوفر لك حلول الكتب و الملفات التعليمية"
        return tv
    }()
    var imgView:UIImageView!
    var catsBtn:BtnPrimary!
    var authBtn:BtnSecondary!
    
    
    override func viewWillAppear(_ animated: Bool) {
        isInitial = true
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
    }
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        imgView = UIImageView(image: UIImage(named: "app-logo"))
        catsBtn = BtnPrimary(frame: .zero)
        authBtn = BtnSecondary(frame: .zero)
        catsBtn.setTitle("المتابعة الى الملفات", for: .normal)
        authBtn.setTitle("تسجيل الدخول", for: .normal)
        
        view.addSubview(titleView)
        view.addSubview(descriptionView)
        view.addSubview(imgView)
        view.addSubview(catsBtn)
        view.addSubview(authBtn)
        
        imgView.anchor(top: main.topAnchor, leading: main.leadingAnchor,trailing: main.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 90))
        titleView.toBottom(of: imgView, marginTop:40)
        descriptionView.toBottom(of: titleView, marginTop:20)
        catsBtn.toBottom(of: descriptionView, marginTop:30)
        authBtn.toBottom(of: catsBtn, marginTop:20)
        
        /*let stack = UIStackView(arrangedSubviews: [imgView, titleView, descriptionView, catsBtn, authBtn])
         stack.axis = .vertical
         //stack.spacing = 2
         stack.alignment = .center
         stack.backgroundColor = .green
         view.addSubview(stack)
         stack.anchor(top: main.topAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor)*/
    }
    
    @objc func auth(){
        router.auth()
    }
    @objc func categories(){
        router.categories(category: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catsBtn.addTarget(self, action: #selector(categories), for: .touchUpInside)
        authBtn.addTarget(self, action: #selector(auth), for: .touchUpInside)
        
        /*let showcase = MaterialShowcase()
        showcase.setTargetView(view: authBtn) // always required to set targetView
        showcase.primaryText = "Help Center"
        showcase.secondaryText = "By signing in, you can get help for your tasks and questions"
        showcase.show(completion: {
            showcase.setTargetView(view: self.catsBtn) // always required to set targetView
            showcase.primaryText = "Education files"
            showcase.secondaryText = "Files Library can be access without having user account"
            showcase.show(completion: {
                // You can save showcase state here
                // Later you can check and do not show it again
            })
        })*/
    }
    
}


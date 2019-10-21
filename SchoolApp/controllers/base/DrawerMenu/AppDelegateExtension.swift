//
//  AppDelegateExtension.swift
//  MyApp
//
//  Created by X on 4/25/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
//import Hero


extension AppDelegate {
    func setOnBoarding() {
        let mainViewController = OnBoardingViewController()
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.isNavigationBarHidden = true
        if window == nil {
            window = UIWindow()
        }
        self.window?.rootViewController = nvc
    }
    func setDrawerMenu() {
        
        
        var mainViewController:MainViewController!
        if UserDefaults.Account.auth() != nil {
            mainViewController = CategororiesViewController()
        } else {
            mainViewController = WelcomeViewController()
        }
        
        let leftViewController = LeftViewController()
        //let rightViewController = RightViewController()
        leftViewController.mainController = mainViewController
        //rightViewController.mainController = mainViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.barTintColor = Utils.appColor
        nvc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = Utils.appColor
        
        //nvc.hero
        
        //leftViewController.mainViewController = nvc
        
        //let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        slideMenuController.title = "Main"
        if window == nil {
            window = UIWindow()
        }
        
        
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor(red: 225.0, green: 61, blue: 48, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
}

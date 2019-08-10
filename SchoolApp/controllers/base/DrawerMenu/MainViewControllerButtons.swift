//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit


extension MainViewController {
    @objc public func goToSearch() {
        print("go goToSearch")
        routerMain.home()
    }
    @objc public func goToWishlist() {
        print("go goToWishlist")
        routerMain.notifications()
    }
    @objc public func goToHome() {
        print("go goToHome")
        routerMain.home()
    }
    @objc public func drawerTapped() {
        if isInitial {
            toggleLeft()
        }else{
            dismissMe()
        }
    }
}

extension MainViewController {
    
    
    func setMultiNavigationBarItem(btns: [UIBarButtonItem]) {
        self.navigationItem.title = Utils.app_name
        self.addLeftBarButtons(btns: btns)
        //self.addRightBarButtonWithImage(UIImage(named: "ic_salary")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    
    func setNavigationBarItem() {
        
        let left0 = UIBarButtonItem(image: defaultMenuImage(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.drawerTapped))
        /*let left1: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"store"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goToHome))
        
        // replaced inside main controller to be accessible
        let left2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"cart"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goToHome))*/
        if right0 == nil {
            right0 = UIBarButtonItem(image: UIImage(named:"magnify"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goToSearch))
        }
        /*let right1: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"magnify"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goToSearch))
        let right2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"heart-outline"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goToWishlist))*/
        navigationItem.leftBarButtonItems = [left0] //, left1, left2
        navigationItem.rightBarButtonItems = [right0] //, right1, right2
        
        /*self.navigationItem.title = Utils.app_name
        if isInitial {
            self.addLeftBarButtonWithImage(self.defaultMenuImage())
        }else{
            self.addRightBarButtonWithImage(UIImage(named: "arrow-left")!)
        }*/
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func defaultMenuImage() -> UIImage {
        if !isInitial {
            return UIImage(named: "arrow-left")!
        }
        
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 2)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 2)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 2)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
}

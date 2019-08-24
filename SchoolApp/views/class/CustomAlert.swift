//
//  CustomAlert.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/15/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit

class CustomAlert: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    var url:String = ""
    
    convenience init(count:String, url:String, image:String) {
        self.init(frame: UIScreen.main.bounds)
        self.url = url
        initialize(count: count, url: url, image: image)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(count:String, url:String, image:String){
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth-16, height: 30))
        titleLabel.text = count //"عدد المشاهدات: "+
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        dialogView.addSubview(titleLabel)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 1)
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        dialogView.addSubview(separatorLineView)
        
        
        
        let countLabel = UILabel(frame: CGRect(x: dialogViewWidth-100, y: frame.height-50, width: 100, height: 50))
        countLabel.text = "عدد المشاهدات: "+count
        countLabel.textAlignment = .center
        countLabel.textColor = .white
        countLabel.backgroundColor = UIColor.black
        dialogView.bringSubviewToFront(countLabel) //;.addSubview(countLabel)
        
        let imageView = UIImageView()
        imageView.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        imageView.frame.size = CGSize(width: dialogViewWidth - 16 , height: dialogViewWidth - 16)
        imageView.kf.setImage(with:  URL(string: image))
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        dialogView.addSubview(imageView)
        
        
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + imageView.frame.height + 8
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedOnBanner))
        dialogView.addGestureRecognizer(tap)
        dialogView.isUserInteractionEnabled = true
        
        countLabel.layer.zPosition = 10
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc private func didTappedOnBanner() {
        print("open url :) ",url)
        UIApplication.shared.open(URL(string : url)!, options: [:], completionHandler: { (status) in
            print("opened in browser")
        })
    }
}


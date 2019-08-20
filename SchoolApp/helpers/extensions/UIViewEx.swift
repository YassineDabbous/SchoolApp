//
//  UIViewEx.swift
//  SchoolApp
//
//  Created by X on 8/5/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit


extension UIScrollView {
    func fitToSize(of card:UIView){
        self.contentSize = card.realSize()
    }
    
    func setAsContentView(_ main:inout UIView){
        addSubview(main)
        main.translatesAutoresizingMaskIntoConstraints = false
        main.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        main.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        main.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        main.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
extension UIView {
    
    func realSize() -> CGSize {
        var contentRect = CGRect.zero
        for v in self.subviews {
            contentRect = contentRect.union(v.frame)
        }
        return contentRect.size
    }
    func realSize1() -> CGSize {
        var elheight:CGFloat = 5
        var elwidth:CGFloat = 5
        for v in self.subviews {
            elheight += v.frame.size.height
            elwidth += v.frame.size.width
        }
        return CGSize(width: elwidth, height: elheight)
    }
    
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
    func loadMe(_ wrapper:UIView){
        let ss = "\(type(of: self))"
        print("--- loadNibNamed ------------------------------------------> ", ss )
        Bundle.main.loadNibNamed(ss, owner: self, options: nil)
        addSubview(wrapper)
        wrapper.frame = self.bounds
        wrapper.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    class func fromNib<T: UIView>() -> T {
        print("+++ T.init()----------------------------------------> ", T.init() )
        print("+++ T.self -----------------------------------------> ", T.self )
        print("+++ self -------------------------------------------> ", self )
        print("+++ String(describing: type(of: T.self)) -----------> ",String(describing: type(of: T.self)))
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)![0] as! T
    }
    func fromNib() -> UIView! {
        //print("--- self ------------------------------------------> ", self )
        print("--- type(of: self) --------------------------------> ", type(of: self))
        print("--- String(describing: type(of: self)) ------------> ",String(describing: type(of: self)))
        let ss = "\(type(of: self))"
        print("--- ss ------------------------------------------> ", ss )
        //let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: ss, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        print("--- return --------------------------------> ", ss )
        return view
    }
}

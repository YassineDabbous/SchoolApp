//
//  UIViewExtensions.swift
//  SchoolApp
//
//  Created by X on 7/11/19.
//  Copyright © 2019 X. All rights reserved.
//
import UIKit
extension UIView {
    
    private static let lineDashPattern: [NSNumber] = [2, 2]
    private static let lineDashWidth: CGFloat = 1.0
    
    func makeDashedBorderLine() {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = UIView.lineDashWidth
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = UIView.lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.maxX, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        layoutIfNeeded()
    }
        
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
        layoutIfNeeded()
    }
    
    func fill(parent:UIView){
        anchor(top: parent.topAnchor, leading: parent.leadingAnchor, bottom: parent.bottomAnchor, trailing: parent.trailingAnchor)
    }
    
    /*
     ** inside the view, at the top
     */
    func atTop(of:UIView, height: Int = 0, marginTop: CGFloat = 0){
        let s = CGSize(width: 0, height: height)
        let m = UIEdgeInsets(top: marginTop, left: 0, bottom: 0, right: 0)
        anchor(top: of.topAnchor, leading: of.leadingAnchor, trailing: of.trailingAnchor, padding: m, size:s)
    }
    /*
     ** inside the view, at the top
     */
    func atBottom(of:UIView, height: Int = 0, marginBottom: CGFloat = 0){
        let s = CGSize(width: 0, height: height)
        let m = UIEdgeInsets(top: 0, left: 0, bottom: marginBottom, right: 0)
        anchor(leading: of.leadingAnchor, bottom: of.bottomAnchor, trailing: of.trailingAnchor, padding: m, size:s)
    }
    
    
    /*
     ** outside the view, under it
     */
    func toBottom(of:UIView, equalWidth to:UIView? = nil, height: Int = 0, marginTop: CGFloat = 0){
        let s = CGSize(width: 0, height: height)
        let m = UIEdgeInsets(top: marginTop, left: 0, bottom: 0, right: 0)
        if to == nil {
            anchor(top: of.bottomAnchor, leading: of.leadingAnchor, trailing: of.trailingAnchor, padding: m, size:s)
        }else{
            anchor(top: of.bottomAnchor, leading: to!.leadingAnchor, trailing: to!.trailingAnchor, padding: m, size:s)
        }
    }
    /*
     ** outside the view, under it
     */
    func toTop(of:UIView, equalWidth to:UIView? = nil, size: CGSize = .zero){
        if to == nil {
            anchor(leading: of.leadingAnchor, bottom: of.topAnchor, trailing: of.trailingAnchor, size:size)
        }else{
            anchor(leading: to!.leadingAnchor, bottom: of.topAnchor, trailing: to!.trailingAnchor, size:size)
        }
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading:NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerX:NSLayoutXAxisAnchor? = nil,
                centerY:NSLayoutYAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        /*guard let top = top,
            let leading = leading,
            let bottom = bottom,
            let trailing = trailing
            else { return }*/
        
        if let centerX = centerX { centerXAnchor.constraint(equalTo: centerX, constant: 0).isActive = true }
        if let centerY = centerY { centerYAnchor.constraint(equalTo: centerY, constant: 0).isActive = true }
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
}

//
//  BaseTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//
import UIKit

open class BaseTableViewCell0 : UITableViewCell {
    class var identifier: String { return "BaseTableViewCell" }
    
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
    }
    
    open class func height() -> CGFloat {
        return 48
    }
    
    open func setData(_ data: Any?) {
        //self.backgroundColor = UIColor.white
        //self.titleView.font = UIFont.italicSystemFont(ofSize: 18)
        //self.titleView.textColor = UIColor.black
        if let menu = data as? [String] {
            self.titleView.text = menu[0]
            
            let origImage = UIImage(named: menu[1])
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            self.imgView.image = tintedImage
            self.imgView.tintColor = Utils.appColor
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
  
}

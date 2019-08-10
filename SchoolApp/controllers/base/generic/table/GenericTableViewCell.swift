//
//  GenericTableViewCell.swift
//  MyApp
//
//  Created by X on 4/21/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
class GenericTableViewCell<T> : UITableViewCell, ReusableView{
    var card:UIView!
    var item: T? {
        didSet{
            bind()
        }
    }
    
    var onAction: ((T?, Action) -> ())?
    
    func bind() {
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addTapRecognizer()
        drawCard()
        loadMe()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTapRecognizer()
        drawCard()
        loadMe()
    }
    func drawCard(){
        card = UIView(frame: .zero)
        self.addSubview(card)
        card.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                    padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    func loadMe() { // overriden in child class for programmatic views
        /*let view:UIView = fromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_:)))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)*/
    }
    func addTapRecognizer(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_:)))
        //tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    @objc func onTapGesture(_ gesture:UITapGestureRecognizer)
    {
        print("Tapped!!")
        onAction?(item, .show)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

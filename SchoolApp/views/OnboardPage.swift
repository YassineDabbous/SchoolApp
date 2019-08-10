//
//  OnboardPage.swift
//  SchoolApp
//
//  Created by X on 8/10/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
import SwiftyOnboard

class OnboardPage: SwiftyOnboardPage {
    
    lazy var titleLabel: LabelBold = {
       let v = LabelBold()
        return v
    }()
    lazy var image: UIImageView = {
        let v = UIImageView(image: UIImage(named: "logo"))
        return v
    }()
    lazy var subTitleLabel: LabelRegular = {
        let v = LabelRegular()
        return v
    }()
    
    func anchorMe(){
        self.addSubview(image)
        image.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 40, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 100))
        
        self.addSubview(titleLabel)
        titleLabel.toBottom(of: image)
        
        self.addSubview(subTitleLabel)
        subTitleLabel.toBottom(of: titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

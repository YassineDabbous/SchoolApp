//
//  ResetViewController.swift
//  MyApp
//
//  Created by X on 4/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class ResetViewController: BaseViewController {
    
    
    let emailField: UITextField = {
        let lbl = Input()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    var recoverBtn: BtnPrimary!
    
    lazy var router:AuthRouter = AuthRouter(viewController: self)
    
    
    @objc func recover() {
        if let emailTxt = emailField.text {
            perform(APIClient.forgotten(email: emailTxt)){ success, data in
                Alerts.ok(vc: self)
            }
        }
        //router.dismiss()
    }
    
    
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        recoverBtn = BtnPrimary(frame: .zero)
        recoverBtn.setTitle(.localized(.Confirm), for: .normal)
        emailField.placeholder = .localized(.Email)
        
        view.addSubview(emailField)
        view.addSubview(recoverBtn)
        
        /*let stack = UIStackView(arrangedSubviews: [emailField, recoverBtn])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 5
        view.addSubview(stack)
        stack.anchor(top: main.topAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor)*/
        
        recoverBtn.atBottom(of: main, marginBottom:10)
        emailField.toTop(of: recoverBtn, marginBottom:20)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(.PasswordReset)
        addBackbtn()
        
        recoverBtn.addTarget(self, action: #selector(recover), for: .touchUpInside)

        //self.moveWithKeyboard()
    }
    
    

}

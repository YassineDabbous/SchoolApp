//
//  AuthViewController.swift
//  MyApp
//
//  Created by X on 4/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class AuthViewController: BaseViewController {
    
    lazy var router:AuthRouter = AuthRouter(viewController: self)
    
    let emailField: Input = {
        let lbl = Input()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        //lbl.textAlignment = .left
        return lbl
    }()
    
    var passwordField: UITextField = {
        let lbl = Input()
        lbl.isSecureTextEntry = true
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        //lbl.textAlignment = .left
        return lbl
    }()
    
    var forgetLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        //lbl.textAlignment = .left
        return lbl
    }()
    
    var registerBtn:BtnPrimary!
    var recoverBtn:BtnSecondary!
    var loginBtn:BtnPrimary!
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        registerBtn = BtnPrimary(frame: .zero)
        recoverBtn = BtnSecondary(frame: .zero)
        loginBtn = BtnPrimary(frame: .zero)
        
        //emailField = UITextField(frame: .zero)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgetLabel)
        view.addSubview(loginBtn)
        view.addSubview(registerBtn)
        view.addSubview(recoverBtn)
        
        emailField.placeholder = .localized(.Email)
        passwordField.placeholder = .localized(.Password)
        forgetLabel.text = .localized(.ForgotPassword)
        loginBtn.setTitle(.localized(.Login), for: .normal)
        registerBtn.setTitle(.localized(.Register), for: .normal)
        recoverBtn.setTitle(.localized(.PasswordReset), for: .normal)
        
    
        
        recoverBtn.atBottom(of: main, marginBottom:10)
        forgetLabel.toTop(of: recoverBtn, marginBottom:8)
        registerBtn.toTop(of: forgetLabel, marginBottom:8)
        loginBtn.toTop(of: registerBtn, marginBottom:8)
        passwordField.toTop(of: loginBtn, marginBottom:8)
        emailField.toTop(of: passwordField, marginBottom:8)
        
        
        
        /*let stack = UIStackView(arrangedSubviews: [emailField, passwordField , forgetLabel, loginBtn, registerBtn, recoverBtn])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 5
        view.addSubview(stack)
        stack.anchor(top: main.topAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor)*/
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(.Login)
        
        UserDefaults.Account.auth(nil)
        
        recoverBtn.addTarget(self, action: #selector(recover), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(logMe), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerMe), for: .touchUpInside)
        
        let email = UserDefaults.Account.string(forKey: .email_hint)
        emailField.text = email
        
        //self.moveWithKeyboard()
    }
    
    @objc func recover() {
        router.recover()
    }
    
    @objc func logMe() {
        let name = emailField.text
        let password = passwordField.text
        UserDefaults.Account.set(name!, forKey: .email_hint)
        perform(APIClient.login(name: name!, password: password!)){ success, data in
            if let d = data {
                dump(d)
                UserDefaults.Account.auth(d)
                self.router.questions()
            }
        }
        
    }
    
    @objc func registerMe() {
        router.register()
    }
    

}

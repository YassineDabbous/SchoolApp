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
        lbl.textAlignment = .left
        return lbl
    }()
    
    var passwordField: UITextField = {
        let lbl = Input()
        lbl.isSecureTextEntry = true
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    var forgetLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
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
        
        emailField.placeholder = "email"
        passwordField.placeholder = "password"
        forgetLabel.text = "forgot password?"
        loginBtn.setTitle("Login", for: .normal)
        registerBtn.setTitle("Register", for: .normal)
        recoverBtn.setTitle("Recover", for: .normal)
        
        
        emailField.atTop(of: main, marginTop: 80)
        passwordField.toBottom(of: emailField, marginTop:40)
        forgetLabel.toBottom(of: passwordField, marginTop:40)
        loginBtn.toBottom(of: forgetLabel, marginTop:40)
        registerBtn.toBottom(of: loginBtn, marginTop:40)
        recoverBtn.toBottom(of: registerBtn, marginTop:40)
        
        
        
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
        navigationItem.title = "Login"
        
        UserDefaults.Account.auth(nil)
        
        recoverBtn.addTarget(self, action: #selector(recover), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(logMe), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerMe), for: .touchUpInside)
        
        let email = UserDefaults.Account.string(forKey: .email_hint)
        emailField.text = email
        
        self.moveWithKeyboard()
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
                self.router.dismiss()
            }
        }
        
    }
    
    @objc func registerMe() {
        router.register()
    }
    

}

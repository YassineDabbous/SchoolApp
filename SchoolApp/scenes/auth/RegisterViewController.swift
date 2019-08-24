//
//  RegisterViewController.swift
//  MyApp
//
//  Created by X on 4/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    lazy var router:AuthRouter = AuthRouter(viewController: self)
    
    var firstnameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var passwordConfirmationField: UITextField!
    //var acceptSwitcher: UISwitch!
    var registerBtn:BtnPrimary!
    
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        registerBtn = BtnPrimary(frame: .zero)
        firstnameField = Input(frame: .zero)
        emailField = Input(frame: .zero)
        passwordField = Input(frame: .zero)
        passwordConfirmationField = Input(frame: .zero)
        passwordField.isSecureTextEntry = true
        passwordField.isSecureTextEntry = true
        
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(firstnameField)
        view.addSubview(passwordConfirmationField)
        view.addSubview(registerBtn)
        
        firstnameField.placeholder = .localized(.Name)
        emailField.placeholder = .localized(.Email)
        passwordField.placeholder = .localized(.Password)
        passwordConfirmationField.placeholder = .localized(.PasswordConfirmation)
        registerBtn.setTitle(.localized(.Register), for: .normal)
        
        
        /*firstnameField.atTop(of: main, marginTop: 80)
        emailField.toBottom(of: firstnameField, marginTop:40)
        passwordField.toBottom(of: emailField, marginTop:40)
        passwordConfirmationField.toBottom(of: passwordField, marginTop:40)
        registerBtn.toBottom(of: passwordConfirmationField, marginTop:40)*/
        
        
        registerBtn.atBottom(of: main, marginBottom:10)
        passwordConfirmationField.toTop(of: registerBtn, marginBottom:20)
        passwordField.toTop(of: passwordConfirmationField, marginBottom:8)
        emailField.toTop(of: passwordField, marginBottom:8)
        firstnameField.toTop(of: emailField, marginBottom:8)
        
        
        /*let stack = UIStackView(arrangedSubviews: [firstnameField, emailField, passwordField , passwordConfirmationField, registerBtn])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 5
        view.addSubview(stack)
        stack.anchor(top: main.topAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor)*/
        
    }
    
    
    @objc func registerMe() {
        let firstname = firstnameField.text ?? ""
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let confirm = passwordConfirmationField.text ?? ""
        //let agree = acceptSwitcher.isOn ? "1" : "0"
        if confirm.elementsEqual(password) {
            let user = RegisterRequest(firstname: firstname, email: email, password: password)
            perform(APIClient.register(request: user)){ success, data in
                if let d = data {
                    dump(d)
                    UserDefaults.Account.auth(d)
                    self.router.questions()
                }
            }
        } else {
            Alerts.showAlert(vc: self, title: .localized(.Error), message: .localized(.msgConfirmation)) {
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(.Register)
        addBackbtn()
        
        registerBtn.addTarget(self, action: #selector(registerMe), for: .touchUpInside)
        view.layoutIfNeeded()
        //self.moveWithKeyboard()
    }

}

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
        
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(firstnameField)
        view.addSubview(passwordConfirmationField)
        view.addSubview(registerBtn)
        
        firstnameField.placeholder = "Name"
        emailField.placeholder = "email"
        passwordField.placeholder = "password"
        passwordConfirmationField.placeholder = "password Confirmation"
        registerBtn.setTitle("Register", for: .normal)
        
        
        firstnameField.atTop(of: main, marginTop: 80)
        emailField.toBottom(of: firstnameField, marginTop:40)
        passwordField.toBottom(of: emailField, marginTop:40)
        passwordConfirmationField.toBottom(of: passwordField, marginTop:40)
        registerBtn.toBottom(of: passwordConfirmationField, marginTop:40)
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
                    self.router.dismiss()
                }
            }
        } else {
            Alerts.showAlert(vc: self, title: .localized(.Error), message: .localized(.changePassword)) {
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Register"
        addBackbtn()
        
        registerBtn.addTarget(self, action: #selector(registerMe), for: .touchUpInside)
    }

}

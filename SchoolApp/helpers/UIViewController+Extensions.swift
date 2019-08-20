//
//  UIViewController+Extensions.swift
//  MyApp
//
//  Created by X on 5/13/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
import PromiseKit


extension UIViewController {
    
    
    func perform<D, T:Promise<BaseResponse<D>>>(_ request:T, _ completion: @escaping (Bool, D?)  -> Void){
        request.done{ data in
                self.handleSuccess(data)
                completion(data.success, data.data?.getData())
            self.onResponseHandled(true)
        }.catch { error in
                self.handleError(error)
                completion(false, nil)
            self.onResponseHandled(false)
        }
    }
    
    @objc func onResponseHandled(_ success:Bool){}
    
    func handleSuccess<T:Decodable>(_ response:BaseResponse<T>){
        if let errors = response.error , errors.count > 0 {
            for e in errors {
                Alerts.showMultiAlert(vc: self, title: .localized(.Error), message: e){
                }
                //Toast.show(message: e, controller: self)
            }
        }
        if let msg = response.message, !msg.elementsEqual("") {
            Alerts.showAlert(vc: self, title: .localized(.Alert), message: msg){
            }
        }
    }
    @objc func handleError(_ error:Error){
        print(error.localizedDescription)
        //Alerts.showMultiAlert(vc: self, title: "error", message: error.localizedDescription){
        //}
        //Toast.show(message: error.localizedDescription, controller: self)
    }
    
    func dismissMe(){
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func back() {
        dismissMe()
    }
    func addBackbtn(){
        let backBtn = UIButton(frame: CGRect(x: 10, y: 20, width: 30, height: 30))
        backBtn.setImage(UIImage(named: "arrow-left"), for: .normal)
        backBtn.setTitle("", for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backBtn)
    }
    
    
    
    
    // hide Keyboard when view tapped
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        print("hide Keyboard when view tapped")
        view.endEditing(true)
    }
    
    
    
    // move view with Keyboard
    func moveWithKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let offset = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            /*if self.view.frame.origin.y == 0 {
             self.view.frame.origin.y -= keyboardSize.height
             }*/
            
            if keyboardSize.height == offset.height {
                if self.view.frame.origin.y == 0 {
                    UIView.animate(withDuration: 0.1, animations: { () -> Void in
                        self.view.frame.origin.y -= keyboardSize.height
                    })
                }
            } else {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.view.frame.origin.y += keyboardSize.height - offset.height
                })
            }
            print(self.view.frame.origin.y)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        /*if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //self.view.frame.origin.y = 0
            self.view.frame.origin.y += keyboardSize.height
        }*/
    }
}

//
//  Alerts.swift
//  MyApp
//
//  Created by X on 6/13/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
import UIKit
class Alerts {
    
    static var msgs:[String] = []
    static var shown = false
    public static func showMultiAlert(vc:UIViewController, title:String, message:String?, _ completion: @escaping ()  -> Void) {
        dump(Alerts.msgs)
        Swift.print("msgs count is ", Alerts.msgs.count)
        if let message = message {
            Alerts.msgs.append(message)
        }
        if !shown {
            shown = !shown
            let msg = Alerts.msgs.removeFirst()
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: .localized(.ok), style: UIAlertAction.Style.default) {
                UIAlertAction in
                completion()
                Swift.print("msgs count check ", Alerts.msgs.count)
                shown = !shown
                if  Alerts.msgs.count > 0 {
                    showMultiAlert(vc: vc, title: .localized(.Alert), message: nil){}
                }
            }
            alertController.addAction(okAction)
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    public static func showAlertInput(vc:UIViewController, title:String = "Enter a value", contentType:UITextContentType = .jobTitle , placeholder:String = "", _ completion: @escaping (String)  -> Void) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = placeholder
            textField.textContentType = contentType
        })
        let okAction = UIAlertAction(title: .localized(.ok), style: UIAlertAction.Style.default) {
            UIAlertAction in
            let textField = alertController.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            completion(textField.text!)
        }
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    public static func showAlert(vc:UIViewController, title:String, message:String, _ completion: @escaping ()  -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: .localized(.ok), style: UIAlertAction.Style.default) {
            UIAlertAction in
            completion()
        }
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    public static func showAlert(vc:UIViewController, title:String, message:String, okBtnTxt:String, cancelBtnTxt:String, _ okCompletion: @escaping ()  -> Void, _ cancelCompletion: @escaping ()  -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okBtnTxt, style: UIAlertAction.Style.default) {
            UIAlertAction in
            okCompletion()
        }
        let cancelAction = UIAlertAction(title: cancelBtnTxt, style: UIAlertAction.Style.default) {
            UIAlertAction in
            cancelCompletion()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    public static func ok(vc:UIViewController) {
        Alerts.showAlert(vc: vc, title: .localized(.done), message: ""){
        }
    }
    
}

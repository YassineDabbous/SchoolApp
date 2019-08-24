//
//  AppHelper.swift
//  SchoolApp
//
//  Created by X on 8/6/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class AppHelper {
    /* call it :
     rateApp(appId: "id959379869") { success in
     print("RateApp \(success)")
     }
     */
    static func rateApp(completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + Utils.app_id) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    
    
    /////// send mail
    static func sendEmail(vc:UIViewController, address:String = Utils.email, message:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = vc as? MFMailComposeViewControllerDelegate
            mail.setToRecipients([address])
            mail.setMessageBody("<p>\(message)</p>", isHTML: true)
            vc.present(mail, animated: true)
        } else {
            Alerts.showAlert(vc: vc, title: .localized(.Error), message: "can't send email"){}
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    ///// share app
    static func shareApp(vc:UIViewController){
        self.shareText(vc: vc, text: Utils.app_link)
    }
    
    static func shareText(vc:UIViewController, text:String){
        let avc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        avc.popoverPresentationController?.sourceView = vc.view // so that iPads won't crash
        //avc.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        vc.present(avc, animated: true)
    }
}

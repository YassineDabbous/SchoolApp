//
//  AppDelegateExtensions.swift
//  SchoolApp
//
//  Created by X on 8/6/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import OneSignal

extension AppDelegate {
    
    func setUpOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: Utils.ONESIGNAL_APP_KEY,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
}

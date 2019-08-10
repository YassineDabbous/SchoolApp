//
//  NotificationsHelper.swift
//  SchoolApp
//
//  Created by X on 8/6/19.
//  Copyright © 2019 X. All rights reserved.
//

import UserNotifications

public class NotificationsHelper {
    
    public static func notification(title:String, description:String, date:Date){
        self.initNotificationSetupCheck()
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.subtitle = Utils.app_name
        notification.body = description
        
        let triggerDaily = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: date.description, content: notification, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    static func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
        { (success, error) in
            if success {
                Utils.print("Permission Granted")
            } else {
                Utils.print("There was a problem!")
            }
        }
    }
}

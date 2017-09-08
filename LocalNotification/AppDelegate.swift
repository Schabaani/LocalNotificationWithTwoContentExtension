//
//  AppDelegate.swift
//  NotificationTutorial
//
//  Created by Amir Shabani on 9/3/17.
//  Copyright © 2017 Sete. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    
    
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let chatID = userInfo["chatID"] as? String {
            print("go to chat id page \(chatID)")
        }
        
        switch response.actionIdentifier {
        case NotificationActions.ActionTutorial.readLater:
            print("Save Tutorial For Later")
        case NotificationActions.ActionTutorial.unsubscribe:
            print("Unsubscribe Reader")
        default:
            print("Other Action")
        }
        
        completionHandler()
    }
    
    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        print("Recived: \(userInfo)")
        
        //completionHandler(.NewData)
        
    }
    
}

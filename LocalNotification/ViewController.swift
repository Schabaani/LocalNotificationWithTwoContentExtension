//
//  ViewController.swift
//  NotificationTutorial
//
//  Created by Amir Shabani on 9/3/17.
//  Copyright © 2017 Sete. All rights reserved.
//

import UIKit
import UserNotifications
struct NotificationActions {
    
    struct Category {
        static let tutorial = "tutorial"
        static let toDo = "toDo"
    }
    
    struct ActionTutorial {
        static let readLater = "readLater"
        static let showDetails = "showDetails"
        static let unsubscribe = "unsubscribe"
    }
    struct ActionToDo {
        static let readNow = "readNow"
    }
    
}

class ViewController: UIViewController {
    var uuid = ""
    @IBAction func didPress(_ sender: Any) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                // schedule push notifaction
                self.scheduleNotification()
            } else {
                // .sound, .badge, .alert
                // user has not given permisson, so I should ask permisson
                UNUserNotificationCenter.current().requestAuthorization(options: [], completionHandler: { (granted, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if granted {
                            self.scheduleNotification()
                        }
                    }
                })
            }
        }
    }
    func scheduleNotification() {
        setupCategories()
        
        let content =  createContent()
        let trigger = setupTrigger()
        uuid = UUID().uuidString
        let notificationRequest = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print(error)
            } else {
                print("scheduled!")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupCategories() {
        
        let actionReadLater = UNNotificationAction(identifier: NotificationActions.ActionTutorial.readLater, title: "Read Later", options: [])
        let actionShowDetails = UNNotificationAction(identifier: NotificationActions.ActionTutorial.showDetails, title: "Show Details", options: [.foreground])
        let actionUnsubscribe = UNNotificationAction(identifier: NotificationActions.ActionTutorial.unsubscribe, title: "Unsubscribe", options: [.destructive, .authenticationRequired])
        let actionReadNow = UNNotificationAction(identifier: NotificationActions.ActionToDo.readNow, title: "Read Now", options: [])
        
        // Define Category
        let toDoCategory = UNNotificationCategory(identifier: NotificationActions.Category.toDo, actions: [actionReadNow],  intentIdentifiers: [], options: [])
        
        let tutorialCategory = UNNotificationCategory(identifier: NotificationActions.Category.tutorial, actions: [actionReadLater, actionShowDetails, actionUnsubscribe], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([ toDoCategory, tutorialCategory])
    }
    
    func setupTrigger() -> UNTimeIntervalNotificationTrigger{
        return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    }
    
    func createContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "Nivo!"
        content.body = "  Your text comes here"
        content.sound = UNNotificationSound.default()
        content.userInfo = ["chatID": "title", "UUID": "UU"]
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground") // when you want show the notification when app is foreground.
        // change to NotificationActions.Category.tutorial to see it's differences
        content.categoryIdentifier = NotificationActions.Category.toDo
        if let path = Bundle.main.url(forResource: "account", withExtension: "png") {
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: path, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        return content
    }
    
    func removeNotification (uuid: String){
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers:
                [uuid])
    }
    
}


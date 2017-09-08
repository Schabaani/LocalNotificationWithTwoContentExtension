//
//  NotificationViewController.swift
//  Tutorial
//
//  Created by Pishtaz on 9/5/17.
//  Copyright © 2017 Sete. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        //self.label?.text = notification.request.content.body
    }

}

//
//  NotificationViewController.swift
//  ToDo
//
//  Created by Amir Shabani on 9/5/17.
//  Copyright © 2017 Sete. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        let url =  notification.request.content.attachments[0].url
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        image.image = UIImage(data: data!)
    }

}

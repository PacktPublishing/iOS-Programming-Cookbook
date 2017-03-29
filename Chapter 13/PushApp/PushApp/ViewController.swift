//
//  ViewController.swift
//  PushApp
//
//  Created by Hossam Ghareeb on 1/3/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.reminderDatePicker.minimumDate = Date()
        self.titleTextField.delegate = self
    }


    @IBAction func didClickOnAddButton(_ sender: Any) {
        guard let title = titleTextField.text, let body = bodyTextView.text else {
            print("Please enter all information")
            return
        }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.reminderDatePicker.date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let center = UNUserNotificationCenter.current()
        let identifier = "ReminderNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { error in
            if let error = error {
                print("Error in scheduling the notification \(error)")
            }
            else{
                DispatchQueue.main.async {
                    print("Scheduling done successfully")
                    self.titleTextField.text = ""
                    self.bodyTextView.text = ""
                }
                
            }
        })
        
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

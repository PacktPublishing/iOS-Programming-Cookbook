//
//  AppDelegate.swift
//  PushApp
//
//  Created by Hossam Ghareeb on 1/3/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit
import UserNotifications

let ChatMessageCategory = "ChatMessageCategory"
let ReplyActionIdentifier = "ReplyActionIdentifier"
let CoolActionIdentifier = "CoolActionIdentifier"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerForPushNotifications()
        return true
    }
    
    func registerForPushNotifications(){
        let application = UIApplication.shared
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // actions based on whether notifications were authorized or not
            
            if granted{
                self.customizePushNotificationActions()
            }
            
        }
        application.registerForRemoteNotifications()
    }
    
    func customizePushNotificationActions(){
        let center = UNUserNotificationCenter.current()
        let replyAction = UNNotificationAction(identifier: ReplyActionIdentifier, title: "Reply", options: .foreground)
        let coolAction = UNNotificationAction(identifier: CoolActionIdentifier, title: "👍", options: .destructive)
        let notificationCategory = UNNotificationCategory(identifier: ChatMessageCategory, actions: [replyAction, coolAction], intentIdentifiers: [], options: .customDismissAction)
        var categories = Set<UNNotificationCategory>()
        categories.insert(notificationCategory)
        center.setNotificationCategories(categories)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        completionHandler(.alert)
    }
    
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        let userInfo = response.notification.request.content.userInfo
        
        if let aps = userInfo["aps"]{
            print(aps)
        }
        if let customData = userInfo["foo"]{
            print(customData)
        }
        
        switch response.actionIdentifier {
        case ReplyActionIdentifier:
            print("User did click on reply. Display the chat log and text box to reply.")
        case CoolActionIdentifier:
            print("Send cool emojo 👍 to the user")
        default:
            print(response.actionIdentifier)
        }
        
        completionHandler()
    }
}




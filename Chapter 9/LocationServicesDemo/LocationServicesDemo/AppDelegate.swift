//
//  AppDelegate.swift
//  LocationServicesDemo
//
//  Created by Hossam Ghareeb on 10/30/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Check authorization here....
        }
        
        self.locationManager.delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        didEnterOrExitRegion(region: region)

    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        didEnterOrExitRegion(region: region)
    }
    
    func didEnterOrExitRegion(region: CLRegion){
        if let region = region as? CLCircularRegion{
            
            
            let id = (region.identifier as NSString).integerValue
            let notes = UserDefaults.standard.string(forKey: "Fence\(id)")
            
            if UIApplication.shared.applicationState == .active {
                
                print("Did Enter/Exit region. Notes: \(notes)")
            } else {
                // Otherwise present a local notification
                
                let content = UNMutableNotificationContent()
                content.body = notes!
                content.sound = UNNotificationSound.default()
                content.title = "Geo fence detection"
                
                let request = UNNotificationRequest(identifier: "Fence\(id)", content: content, trigger: nil)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                    print("Did finish sending notification with error \(error)")
                })
            }
        }
    }
}


//
//  AppDelegate.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            let center = UNUserNotificationCenter.current()
            center.delegate = self

            // Request notification permission
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                print("Permission granted: \(granted)")
            }

            // Register notification category for tap handling
            let openAction = UNNotificationAction(identifier: "OPEN_ACTION", title: "Open", options: [.foreground])
            let category = UNNotificationCategory(identifier: "openNotifications",
                                                  actions: [openAction],
                                                  intentIdentifiers: [],
                                                  options: [])
            center.setNotificationCategories([category])

            return true
        }

        // Show banner if app is in foreground
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound])
        }

        // Handle tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        if response.notification.request.content.categoryIdentifier == "openNotifications" {

            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                      let window = windowScene.windows.first else {
                    completionHandler()
                    return
                }

                let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                let notificationVC = storyboard.instantiateViewController(withIdentifier: "YourNotificationVC") as! YourNotificationVC

                // If root is UINavigationController
                if let navController = window.rootViewController as? UINavigationController {
                    navController.pushViewController(notificationVC, animated: true)

                // If root is TabBarController with nav controller inside
                } else if let tabBar = window.rootViewController as? UITabBarController,
                          let navController = tabBar.selectedViewController as? UINavigationController {
                    navController.pushViewController(notificationVC, animated: true)

                // Fallback: replace root
                } else {
                    window.rootViewController = UINavigationController(rootViewController: notificationVC)
                    window.makeKeyAndVisible()
                }
            }
        }

        completionHandler()
    }

    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


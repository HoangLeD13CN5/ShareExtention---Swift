//
//  AppDelegate.swift
//  ShareExtentionRecive
//
//  Created by Hoang Le on 12/13/18.
//  Copyright © 2018 Hoang Le. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

extension AppDelegate {
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let userDefaults = UserDefaults(suiteName: "group.demo.ShareExtentionRecive")
        if let key = url.absoluteString.components(separatedBy: "=").last,
            let sharedUrl = userDefaults?.object(forKey: key) as? Data {
            do {
                let filePath = self.documentsPathForFileName(name: "video.mp4")
                let videoFileURL = URL(fileURLWithPath: filePath)
                deleteExistingFile(url: videoFileURL)
                try sharedUrl.write(to: videoFileURL, options: .atomic)
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                homeVC.urlPlayer = videoFileURL
                let navVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                
                navVC.viewControllers = [homeVC]
                self.window?.rootViewController = navVC
                self.window?.makeKeyAndVisible()
                
                return true
            } catch let exp {
                 print("GETTING EXCEPTION \(exp.localizedDescription)")
               return false
            }
        }
        
        return false
    }
    
    func documentsPathForFileName(name: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath.appending(name)
    }
    
    func deleteExistingFile(url: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
        }
        catch _ as NSError {
            
        }
    }
    
}

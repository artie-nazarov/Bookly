//
//  AppDelegate.swift
//  Bookly
//
//  Created by Artem Nazarov on 1/24/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let brain = LimitsBrain()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let usDef = UserDefaults.standard
        
        if usDef.integer(forKey: "launched") == 0
        {
            let encoded = NSKeyedArchiver.archivedData(withRootObject: bookLibraryArray)
            usDef.set(encoded, forKey: "shopLibrary")
            usDef.set(1, forKey: "launched")
        }
        
        FIRApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       
        UserDefaults.standard.set(buttonSetLimitsIsVisible, forKey: "buttonSetLimitsIsVisible")
        UserDefaults.standard.set(balance, forKey: "balance")
        
    
        
        UserDefaults.standard.synchronize()

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        
        

       

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        if let x = UserDefaults.standard.object(forKey: "balance") as? Int {
            balance = x}
        if let x = UserDefaults.standard.object(forKey: "pagesReadDaily")as? Int {
            pagesReadDaily = x}
        if let x = UserDefaults.standard.object(forKey: "pagesReadGenerally")as? Int {
            pagesReadGenerally = x}
        if let x = UserDefaults.standard.object(forKey: "buttonSetLimitsIsVisible")as? Bool{
            buttonSetLimitsIsVisible = x
        }
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            self.saveContext()
        } else {
            // Fallback on earlier versions
        }
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Bookly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    @available(iOS 10.0, *)
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


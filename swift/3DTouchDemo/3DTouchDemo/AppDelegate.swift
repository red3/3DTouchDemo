//
//  AppDelegate.swift
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let main = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: main)
        window?.makeKeyAndVisible()
        
        // Install initial versions of our two extra dynamic shortcuts.
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            // Construct the items.
            let shortcut2 = UIMutableApplicationShortcutItem(type: "Second", localizedTitle: "Play", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .Play), userInfo:nil)

            let shortcut3 = UIMutableApplicationShortcutItem(type: "Third", localizedTitle: "Play", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .Play), userInfo:nil)
            
            let shortcut4 = UIMutableApplicationShortcutItem(type: "Fourth", localizedTitle: "Pause", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "img_share.png"), userInfo:nil)
            
            // Update the application providing the initial 'dynamic' shortcut items.
            application.shortcutItems = [shortcut2, shortcut3, shortcut4]
        }
        return shouldPerformAdditionalDelegateHandling;
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        
        launchedShortcutItem = nil
    }
    
    /*
    Called when the user activates your application by selecting a shortcut on the home screen, except when
    application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) returns `false`.
    You should handle the shortcut in those callbacks and return `false` if possible. In that case, this
    callback is used if your application is already launched in the background.
    */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }
    
    func handleShortCutItem(item: UIApplicationShortcutItem) ->Bool {
        let handled = true;
        let navi = self.window!.rootViewController as? UINavigationController
        let main = navi!.viewControllers[0] as? MainViewController;
        main!.handleTheShortCutItem(item);
        return handled;
    
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


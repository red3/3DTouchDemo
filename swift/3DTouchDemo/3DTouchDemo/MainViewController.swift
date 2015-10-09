//
//  MainTableViewController.swift
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

import UIKit



class MainViewController: UITableViewController {
    // MARK: Properties
    
    /// A simple data structure to populate the table view.
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    // MARK: Properties
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    /// An alert controller used to notify the user if 3D touch is not available.
    var alertController: UIAlertController?
    
    /// Pre-defined shortcuts; retrieved from the Info.plist, lazily.
    lazy var staticShortcuts: [UIApplicationShortcutItem] = {
        // Obtain the `UIApplicationShortcutItems` array from the Info.plist. If unavailable, there are no static shortcuts.
        guard let shortcuts = NSBundle.mainBundle().infoDictionary?["UIApplicationShortcutItems"] as? [[String: NSObject]] else { return [] }
        
        // Use `flatMap(_:)` to process each dictionary into a `UIApplicationShortcutItem`, if possible.
        let shortcutItems = shortcuts.flatMap { shortcut -> [UIApplicationShortcutItem] in
            // The `UIApplicationShortcutItemType` and `UIApplicationShortcutItemTitle` keys are required to successfully create a `UIApplicationShortcutItem`.
            guard let shortcutType = shortcut["UIApplicationShortcutItemType"] as? String,
                var shortcutTitle = shortcut["UIApplicationShortcutItemTitle"] as? String else { return [] }
            
            if let localizedTitle = NSBundle.mainBundle().localizedInfoDictionary?[shortcutTitle] as? String {
                shortcutTitle = localizedTitle
            }
            
            // The `UIApplicationShortcutItemSubtitle` key is optional and doesn't need to be unwrapped.
            var shortcutSubtitle = shortcut["UIApplicationShortcutItemSubtitle"] as? String
            if shortcutSubtitle != nil {
                shortcutSubtitle = NSBundle.mainBundle().localizedInfoDictionary?[shortcutSubtitle!] as? String
            }
            
            return [
                UIApplicationShortcutItem(type: shortcutType, localizedTitle: shortcutTitle, localizedSubtitle: shortcutSubtitle, icon: nil, userInfo: nil)
            ]
        }
        
        return shortcutItems
        }()
    
    /// Shortcuts defined by the application and modifiable based on application state.
    lazy var dynamicShortcuts = UIApplication.sharedApplication().shortcutItems ?? []
    
    // MARK: Life Cycel
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        
        // Check for force touch feature, and add force touch/previewing capability.
        if traitCollection.forceTouchCapability == .Available {
            /*
            Register for `UIViewControllerPreviewingDelegate` to enable
            "Peek" and "Pop".
            (see: MasterViewController+UIViewControllerPreviewing.swift)
            
            The view controller will be automatically unregistered when it is
            deallocated.
            */
            registerForPreviewingWithDelegate(self, sourceView: view)
        }
        else {
            // Create an alert to display to the user.
            alertController = UIAlertController(title: "3D Touch Not Available", message: "Unsupported device.", preferredStyle: .Alert)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present the alert if necessary.
        if let alertController = alertController {
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            
            // Clear the `alertController` to ensure it's not presented multiple times.
            self.alertController = nil
        }
    }

    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Static", "Dynamic"][section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? staticShortcuts.count : dynamicShortcuts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        
        let shortcut: UIApplicationShortcutItem
        
        if indexPath.section == 0 {
            // Static shortcuts (cannot be edited).
            shortcut = staticShortcuts[indexPath.row]
            cell.accessoryType = .None
            cell.selectionStyle = .None
        }
        else {
            // Dynamic shortcuts.
            shortcut = dynamicShortcuts[indexPath.row]
        }
        
        cell.textLabel?.text = shortcut.localizedTitle
        cell.detailTextLabel?.text = shortcut.localizedSubtitle
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            return;
        }
        let shortcut = dynamicShortcuts[indexPath.row]

        let detail = DetailViewController()
        detail.shortcutItem = shortcut
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    // MARK: Public func
    public func handleTheShortCutItem(item: UIApplicationShortcutItem) {
        
    }
    
}

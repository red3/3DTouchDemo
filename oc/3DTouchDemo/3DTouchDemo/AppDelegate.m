//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

/// Saved shortcut item used as a result of an app launch, used later when app is activated.
@property (nonatomic, strong) UIApplicationShortcutItem *launchedShortcutItem;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BOOL shouldPerformAdditionalDelegateHandling = YES;
    
    // If a shortcut was launched, handle it
    UIApplicationShortcutItem *shortCut = launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
    if (shortCut) {
        self.launchedShortcutItem = shortCut;
        shouldPerformAdditionalDelegateHandling = NO;
    }
    
    if (application.shortcutItems.count == 0) {
        // Construct the items.
        UIMutableApplicationShortcutItem *shortcut2 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"Second" localizedTitle:@"new" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];

        UIMutableApplicationShortcutItem *shortcut3 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"Third" localizedTitle:@"search" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
        UIMutableApplicationShortcutItem *shortcut4 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"Fourth" localizedTitle:@"share" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_share.png"] userInfo:nil];

        
        // Update the application providing the initial 'dynamic' shortcut items.
        application.shortcutItems = @[shortcut2, shortcut3, shortcut4];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *main = [[MainViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:main];
    [self.window makeKeyAndVisible];

    return shouldPerformAdditionalDelegateHandling;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (!self.launchedShortcutItem) {
        return;
    }
    
    [self handleShortCutItem:self.launchedShortcutItem];
    self.launchedShortcutItem = nil;
    
}

// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    BOOL handledShortCutItem = [self handleShortCutItem:shortcutItem];
    completionHandler(handledShortCutItem);
    
}

- (BOOL)handleShortCutItem:(UIApplicationShortcutItem *)item
{
    BOOL handled = YES;
    UINavigationController *navi = (UINavigationController *)self.window.rootViewController;
    MainViewController *main = navi.viewControllers[0];
    [main handleTheShortCutItem:item];
    return handled;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

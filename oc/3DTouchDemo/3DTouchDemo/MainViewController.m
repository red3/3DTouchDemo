//
//  MainViewController.m
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "MainViewController+UIViewControllerPreviewing.h"

@interface MainViewController () <UITraitEnvironment>

// pre-defined from Info.plist
@property (nonatomic, strong) NSArray *staticShortcuts;
// defined by the application's delegate
@property (nonatomic, strong) NSArray *dynamicShortcuts;

@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation MainViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
    
    // Check for force touch feature, and add force touch/previewing capability.
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        /*
         Register for `UIViewControllerPreviewingDelegate` to enable
         "Peek" and "Pop".
         (see: MasterViewController+UIViewControllerPreviewing.swift)
         
         The view controller will be automatically unregistered when it is
         deallocated.
         */
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    } else {
        // Create an alert to display to the user.
        self.alertController = [UIAlertController alertControllerWithTitle:@"3D Touch Not Available" message:@"Unsupported device." preferredStyle:UIAlertControllerStyleAlert];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Present the alert if necessary.
    if (self.alertController) {
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:self.alertController animated:YES completion:nil];
        // Clear the `alertController` to ensure it's not presented multiple times.
        self.alertController = nil;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.staticShortcuts.count : self.dynamicShortcuts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    
    UIApplicationShortcutItem *shortcut;
    
    if (indexPath.section == 0) {
        // Static shortcuts (cannot be edited).
        shortcut = self.staticShortcuts[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        // Dynamic shortcuts.
        shortcut = self.dynamicShortcuts[indexPath.row];
    }
    
    cell.textLabel.text = shortcut.localizedTitle;
    cell.detailTextLabel.text = shortcut.localizedSubtitle;
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[@"Static", @"Dynamic"][section];

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    UIApplicationShortcutItem *item = self.dynamicShortcuts[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.shortcutItem = item;
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - Public Func
- (void)handleTheShortCutItem:(UIApplicationShortcutItem *)item
{
    if ([item.type isEqualToString:@"First"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ShortCut" message:item.localizedTitle preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.shortcutItem = item;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - Getter
- (NSArray *)dynamicShortcuts
{
    if (_dynamicShortcuts == nil) {
        NSArray *array = [UIApplication sharedApplication].shortcutItems;
        if (array) {
            _dynamicShortcuts = array;
        } else {
            _dynamicShortcuts = @[];
        }
    }
    return _dynamicShortcuts;
}

- (NSArray *)staticShortcuts
{
    if (_staticShortcuts == nil) {
        NSArray *shortcuts = [NSBundle mainBundle].infoDictionary[@"UIApplicationShortcutItems"];
        if (!shortcuts) {
            _staticShortcuts = @[];
            return _staticShortcuts;
        }
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
        for (NSDictionary *shortcut in shortcuts) {
            NSString *type = shortcut[@"UIApplicationShortcutItemType"];
            NSString *title = shortcut[@"UIApplicationShortcutItemTitle"];
            if (!title) {
                continue;
            }
            
            UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title];
            [array addObject:item];
        }
        _staticShortcuts = array;
        
    }
    return _staticShortcuts;
}

- (NSArray *)sampleData
{
    if (_sampleData == nil) {
        _sampleData = @[@{@"title": @"Small", @"preferredHeight": @(160.0)},
                        @{@"title": @"Medium", @"preferredHeight": @(320.0)},
                        @{@"title": @"Large", @"preferredHeight": @(0.0)}  // 0.0 to get the default height
                        ];
    }
    return _sampleData;
}




@end

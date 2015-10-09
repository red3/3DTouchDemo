//
//  MainViewController.h
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController

@property (nonatomic, strong) NSArray *sampleData;

- (void)handleTheShortCutItem:(UIApplicationShortcutItem *)item;

@end

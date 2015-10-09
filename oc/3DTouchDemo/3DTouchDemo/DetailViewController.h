//
//  DetailViewController.h
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

// Used to share information between this controller and its parent.
@property (nonatomic, strong) UIApplicationShortcutItem *shortcutItem;
// Used to show the infomation when this controller is poped by 3DTouch
@property (nonatomic, copy) NSString *previewingTitle;

@end

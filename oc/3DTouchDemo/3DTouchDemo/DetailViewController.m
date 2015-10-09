//
//  DetailViewController.m
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-120)/2.0, 200, 120, 44)];
    label.text = self.shortcutItem.localizedTitle;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *previewingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-120)/2.0, 300, 120, 44)];
    previewingLabel.text = self.previewingTitle;
    previewingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:previewingLabel];
}

#pragma mark - Getter
- (NSArray <id <UIPreviewActionItem>> *)previewActionItems
{
    // set the previewItems
    // avoid the retain cycel
    // __weak MainViewController *weakSelf = self;
    UIPreviewAction *item1 = [UIPreviewAction actionWithTitle:@"Share" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction *item2 = [UIPreviewAction actionWithTitle:@"Delete" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    return @[item1, item2];
}


@end

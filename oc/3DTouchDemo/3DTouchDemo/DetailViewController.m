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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

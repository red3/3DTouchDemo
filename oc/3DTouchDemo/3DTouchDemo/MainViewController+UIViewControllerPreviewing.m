//
//  MainViewController+UIViewControllerPreviewing.m
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

#import "MainViewController+UIViewControllerPreviewing.h"
#import "DetailViewController.h"

@implementation MainViewController (UIViewControllerPreviewing)

/// Create a previewing view controller to be shown at "Peek".
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    // Obtain the index path and the cell that was pressed.
    // guard let indexPath = tableView.indexPathForRowAtPoint(location),
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    
    // Create a detail view controller and set its properties.
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    
    NSDictionary *previewDetail = self.sampleData[indexPath.row];
    detail.previewingTitle = previewDetail[@"title"];
    
    /*
     Set the height of the preview by setting the preferred content size of the detail view controller.
     Width should be zero, because it's not used in portrait.
     */
    detail.preferredContentSize = CGSizeMake(0, [previewDetail[@"preferredHeight"] doubleValue]);
    
    // Set the source rect to the cell frame, so surrounding elements are blurred.
    previewingContext.sourceRect = cell.frame;
    
    return detail;
    
}

/// Present the view controller for the "Pop" action.
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    // Reuse the "Peek" view controller for presentation.
    [self showViewController:viewControllerToCommit sender:self];
}

@end

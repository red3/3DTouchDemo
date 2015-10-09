//
//  MainViewController+UIViewControllerPreviewing.swift
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

import UIKit

extension MainViewController: UIViewControllerPreviewingDelegate {
    // MARK: UIViewControllerPreviewingDelegate
    
    /// Create a previewing view controller to be shown at "Peek".
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Obtain the index path and the cell that was pressed.
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a detail view controller and set its properties.
        let detail = DetailViewController()
        
        let previewDetail = sampleData[indexPath.row]
        detail.previewingTitle = previewDetail.title
        
        /*
        Set the height of the preview by setting the preferred content size of the detail view controller.
        Width should be zero, because it's not used in portrait.
        */
        detail.preferredContentSize = CGSize(width: 0.0, height: previewDetail.preferredHeight)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        previewingContext.sourceRect = cell.frame
        
        return detail
    }
    
    /// Present the view controller for the "Pop" action.
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        showViewController(viewControllerToCommit, sender: self)
    }
}

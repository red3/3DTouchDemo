//
//  DetailViewController.swift
//  3DTouchDemo
//
//  Created by Herui on 15/10/9.
//  Copyright © 2015年 harry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Used to share information between this controller and its parent.
    var  shortcutItem: UIApplicationShortcutItem?
    // Used to show the infomation when this controller is poped by 3DTouch
    var previewingTitle: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let label = UILabel(frame: CGRectMake((view.frame.size.width-120)/2.0, 200, 120, 44))
        label.text = shortcutItem!.localizedTitle
        label.textAlignment = .Center
        view.addSubview(label)
        
        let previewingLabel = UILabel(frame: CGRectMake((view.frame.size.width-120)/2.0, 300, 120, 44))
        previewingLabel.text = previewingTitle
        previewingLabel.textAlignment = .Center
        view.addSubview(previewingLabel)
    }

}

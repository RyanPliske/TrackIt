//
//  SettingsViewController.swift
//  Tracker
//
//  Created by Ryan Pliske on 2/8/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import UIKit

class SettingsViewController: FXFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        // self.view.frame.size.height = 450
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundColor = UIColor.blackColor()
    }
    
    override func awakeFromNib() {
        
        formController.form = settingsForm()
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

}

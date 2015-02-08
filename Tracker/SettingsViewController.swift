//
//  SettingsViewController.swift
//  Tracker
//
//  Created by Ryan Pliske on 2/8/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
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

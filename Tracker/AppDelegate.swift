    //
//  AppDelegate.swift
//  Tracker
//
//  Created by Ryan Pliske on 2/7/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        Parse.setApplicationId("xXgO9EuCmM0fMAPvTk7jxPWQomcQPH40IcrKnCCf",
            clientKey: "ErKp2ZiaCImNSpiUQaCXWEAtClBou0b4qrBk7anU")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }
}


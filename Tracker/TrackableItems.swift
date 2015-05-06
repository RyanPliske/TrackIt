//
//  TrackableItems.swift
//  Tracker
//
//  Created by Ryan Pliske on 5/1/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import Foundation

class TrackableItems {
    
    var regularItems = ["Workouts", "Protein", "Baby Kicks"]
    var sinfulItems  = ["Drinks", "Cigarettes", "Money"]
    let ListOfQuantities = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Custom"]
    
    func getCountOfAllItems() -> Int {
        return regularItems.count + sinfulItems.count
    }
}
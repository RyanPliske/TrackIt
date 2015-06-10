//
//  CurrentDate.swift
//  Tracker
//
//  Created by Ryan Pliske on 5/6/15.
//  Copyright (c) 2015 Tracker. All rights reserved.
//

import Foundation

struct CurrentDate {
    static var thisMonth: Int {
        print(NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate()))
        return NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate())
    }
    
    static var thisYear: Int {
        print(NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate()))
        return NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate())
    }
    
    static var thisDay: Int {
        print(NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: NSDate()))
        return NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: NSDate())
    }
    
    static var year : String {
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("YYYY")
        return formatter.stringFromDate(now)
    }
    
    static let months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    static var days : [Int] {
        let daysAgo = thisDay - 7
        return (daysAgo...thisDay).map {$0}
    }
}
import Foundation

class TRMonthGenerator {
    
    private var trackingDate: NSDate
    
    init(trackingDate: NSDate) {
        self.trackingDate = trackingDate
    }
    
    var weekDayIndexOfTheFirstOfThisMonth: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Year, .Month], fromDate: trackingDate)
        components.day = 1
        let weekDateOfFirstOfTheMonth = calendar.dateFromComponents(components)!
        let currentComponents = calendar.components(.Weekday, fromDate: weekDateOfFirstOfTheMonth)
        return currentComponents.weekday
    }
    var lastDayOfTheMonth: Int {
        let calendar = NSCalendar.currentCalendar()
        let daysRange = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: trackingDate)
        return daysRange.length + 1
    }
    var lastDayOfFirstWeek: Int {
        var lastDay = 1
        for index in 1...7 {
            if index > weekDayIndexOfTheFirstOfThisMonth {
                lastDay++
            }
        }
        return lastDay
    }
    var week1: [Int] {
        var week = [Int]()
        for index in 1...7 {
            if index < weekDayIndexOfTheFirstOfThisMonth {
                week.append(0)
            } else {
                week.append(index)
            }
        }
        return week
    }
    var week2: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 1
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week3: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 8
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week4: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 15
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week5: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 22
        for _ in 1...7 {
            if day < lastDayOfTheMonth {
                week.append(day)
                day++
            } else {
                week.append(0)
            }
        }
        return week
    }
    var week6: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 29
        for _ in 1...7 {
            if day < lastDayOfTheMonth {
                week.append(day)
                day++
            } else {
                week.append(0)
            }
        }
        return week
    }
    
    
}
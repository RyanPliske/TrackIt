import Foundation

class TRMonthGenerator {
    
    private var trackingDate: NSDate
    private var lastDayOfFirstWeek = 1
    
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
    var week1: [Int] {
        var week = [Int]()
        for index in 1...7 {
            if index < weekDayIndexOfTheFirstOfThisMonth {
                week.append(0)
            } else {
                week.append(lastDayOfFirstWeek)
                lastDayOfFirstWeek++
            }
        }
        return week
    }
    var week2: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week3: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 7
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week4: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 14
        for _ in 1...7 {
            week.append(day)
            day++
        }
        return week
    }
    var week5: [Int] {
        var week = [Int]()
        var day = lastDayOfFirstWeek + 21
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
        var day = lastDayOfFirstWeek + 28
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
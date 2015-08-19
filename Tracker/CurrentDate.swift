import Foundation

struct CurrentDate {
    static var thisMonth: Int {
        return NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate()) - 1
    }
    
    static var thisDay: Int {
        return NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: NSDate())
    }
    
    static var thisYear : String {
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("YYYY")
        return formatter.stringFromDate(now)
    }
}
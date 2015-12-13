import UIKit

extension NSDate {
    func isFromSameMonthAs(otherDate: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components([.Day, .Year, .Month], fromDate: self)
        let month = components.month
        components = calendar.components([.Day, .Year, .Month], fromDate: otherDate)
        let otherMonth = components.month
        return month == otherMonth ? true : false
    }
}
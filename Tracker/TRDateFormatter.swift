import Foundation

class TRDateFormatter : NSObject {
    
    let months = [
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
    
    var descriptionForToday : String {
        return self.months[TRCurrentDate.thisMonth] + " \(TRCurrentDate.thisDay), " + TRCurrentDate.thisYear
    }
    
    func descriptionForDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.stringFromDate(date)
    }
}
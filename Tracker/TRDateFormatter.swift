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
        return self.months[CurrentDate.thisMonth] + " \(CurrentDate.thisDay), " + CurrentDate.thisYear
    }
    
    func descriptionForDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.stringFromDate(date)
    }
}
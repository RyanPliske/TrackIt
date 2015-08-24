import Foundation

public class TRDateFormatter : NSObject {
    
    public static var descriptionForToday : String {
        
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
        
        return months[TRCurrentDate.thisMonth] + " \(TRCurrentDate.thisDay), " + TRCurrentDate.thisYear
    }
    
    public static func descriptionForDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.stringFromDate(date)
    }
}
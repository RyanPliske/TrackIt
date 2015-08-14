import Foundation

class ChooseableDates : CustomStringConvertible {
    var month: Int
    
    init(month: String, day: Int){
        if let monthIndex = CurrentDate.months.indexOf(month){
            self.month = monthIndex
        }
        else {
            self.month = 0
        }
        
    }
    
    var description : String {
        return CurrentDate.months[month] + " \(CurrentDate.thisDay), " + CurrentDate.year
    }
}
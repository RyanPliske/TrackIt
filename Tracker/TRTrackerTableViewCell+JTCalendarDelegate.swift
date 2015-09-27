import Foundation
import JTCalendar

extension TRTrackerTableViewCell: JTCalendarDelegate {
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let aDayView = dayView as? JTCalendarDayView {
            //Dot View
            if dateIsIncluded(TRDateFormatter.descriptionForDate(aDayView.date)) {
                aDayView.dotView.hidden = false
                aDayView.dotView.backgroundColor = UIColor.whiteColor()
            } else {
                aDayView.dotView.hidden = true
            }
            // Blue Circle View
            if let selectedDate = dateSelectedOnJTCalendar where calendar.dateHelper.date(selectedDate, isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.whiteColor()
                aDayView.textLabel.textColor = UIColor.TRBabyBlue()
                aDayView.dotView.backgroundColor = UIColor.TRBabyBlue()
            }
            // White Circle View for today
            else if calendar.dateHelper.date(NSDate(), isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.TRBabyBlue()
                aDayView.textLabel.textColor = UIColor.whiteColor()
                aDayView.dotView.backgroundColor = UIColor.whiteColor()
                }
            else {
                aDayView.circleView.hidden = true
                aDayView.textLabel.textColor = UIColor.blackColor()
            }
            
            aDayView.hidden = aDayView.isFromAnotherMonth ? true : false
            
        }
    }
    
    private func dateIsIncluded(date: String) -> Bool {
        let dates = selectedDatesOnJTCalendar.filter { $0 == date }
        if dates.isEmpty {
            return false
        } else {
            return true
        }
    }
}
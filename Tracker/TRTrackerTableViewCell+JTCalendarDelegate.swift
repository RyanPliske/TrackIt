import Foundation
import JTCalendar

extension TRTrackerTableViewCell: JTCalendarDelegate {
        func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
            if let aDayView = dayView as? JTCalendarDayView {
                dateSelectedOnJTCalendar = aDayView.date
                aDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
                UIView.transitionWithView(aDayView, duration: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    aDayView.circleView.transform = CGAffineTransformIdentity
                    self.calendarManager.reload()
                    }, completion: nil)
            }
        }
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let aDayView = dayView as? JTCalendarDayView {
            
            if let selectedDate = dateSelectedOnJTCalendar where calendar.dateHelper.date(selectedDate, isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.blackColor()
                aDayView.textLabel.textColor = UIColor.whiteColor()
            } else {
                aDayView.circleView.hidden = true
                aDayView.textLabel.textColor = UIColor.blackColor()
            }
            
            if dateIsIncluded(TRDateFormatter.descriptionForDate(aDayView.date)) {
                aDayView.dotView.hidden = false
                aDayView.dotView.backgroundColor = UIColor.whiteColor()
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
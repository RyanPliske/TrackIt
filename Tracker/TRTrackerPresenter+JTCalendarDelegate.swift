import Foundation
import JTCalendar

extension TRTrackerPresenter: JTCalendarDelegate {
//    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
//        if let aDayView = dayView as? JTCalendarDayView {
//            dateSelectedOnJTCalendar = aDayView.date
//            aDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
//            UIView.transitionWithView(aDayView, duration: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                aDayView.circleView.transform = CGAffineTransformIdentity
//                self.calendarManager.reload()
//                }, completion: nil)
//        }
//    }
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let aDayView = dayView as? JTCalendarDayView {
            aDayView.hidden = false
            
            if aDayView.isFromAnotherMonth {
                aDayView.hidden = true
            }
            
//            else if calendarManager.dateHelper.date(NSDate(), isTheSameDayThan: aDayView.date) {
//                aDayView.circleView.hidden = false
//                aDayView.circleView.backgroundColor = UIColor.TRSmokeGrey()
//                aDayView.dotView.backgroundColor = UIColor.whiteColor()
//                aDayView.textLabel.textColor = UIColor.whiteColor()
//            }
            
            else if dateSelectedOnJTCalendar != nil && calendarManager.dateHelper.date(dateSelectedOnJTCalendar, isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.blackColor()
                aDayView.textLabel.textColor = UIColor.whiteColor()
            }
            
//            else {
//                aDayView.circleView.hidden = false
//                aDayView.dotView.backgroundColor = UIColor.blueColor()
//                aDayView.textLabel.textColor = UIColor.blackColor()
//            }
            
        }
    }
}
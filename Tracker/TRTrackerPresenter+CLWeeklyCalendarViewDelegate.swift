import Foundation

extension TRTrackerPresenter: CLWeeklyCalendarViewDelegate {
    func dailyCalendarViewDidSelect(date: NSDate!) {
        print(date)
    }
}
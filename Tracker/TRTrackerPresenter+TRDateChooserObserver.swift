import Foundation

extension TRTrackerPresenter: TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate) {
        self.trackerView.setTodaysDateLabelWithText(dateFormatter.descriptionForDate(date))
        self.datetoTrack = date
    }
}
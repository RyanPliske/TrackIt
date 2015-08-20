import Foundation

extension TRTrackerPresenter: TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate) {
        self.trackerView.setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForDate(date))
        self.datetoTrack = date
    }
}
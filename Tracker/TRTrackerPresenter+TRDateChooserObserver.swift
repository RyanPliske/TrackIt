import Foundation

extension TRTrackerPresenter: TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate) {
        self.trackerView.setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForDate(date))
        self.dateToTrack = date
        self.trackerView.trackerTableView.reloadData()
    }
}
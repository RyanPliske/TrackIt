import Foundation

extension TRTrackerPresenter: TRDateChooserObserver {
    func dateSelectedWithDate(date: NSDate) {
        self.trackerView.setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForDate(date))
        self.dateToTrack = date
        if let cells = self.trackerView.trackerTableView.visibleCells as? [TRTrackerTableViewCell] {
            for cell: TRTrackerTableViewCell in cells {
                cell.setSelectedDateOnCalendarWith(dateToTrack)
            }
        }
        trackerView.trackerTableView.reloadData()
        
    }
}
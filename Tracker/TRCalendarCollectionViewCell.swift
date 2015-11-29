import UIKit

protocol TRCalendarCollectionViewCellDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarCollectionViewCell: UICollectionViewCell, TRCalendarViewDelegate {

    weak var delegate: TRCalendarCollectionViewCellDelegate!
    
    private var calendarView: TRCalendarView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.frame = self.bounds
    }
    
    var recordedDays: TRRecordedDays {
        return delegate.recordedDays
    }
    
    func setupWith(trackingDate: NSDate, startColor: UIColor, endColor: UIColor) {
        calendarView = TRCalendarView(trackingDate: trackingDate, withDelegate: self, startColor: startColor, endColor: endColor)
        contentView.addSubview(calendarView)
    }
    
    func redrawGoalSymbols() {
        calendarView.redrawGoalSymbols()
    }
}
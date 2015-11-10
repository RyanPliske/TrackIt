import UIKit

protocol TRCalendarCollectionViewCellDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarCollectionViewCell: UICollectionViewCell, TRCalendarViewDelegate {
    var recordedDays: TRRecordedDays {
       return delegate.recordedDays
    }
    weak var delegate: TRCalendarCollectionViewCellDelegate!
    private var calendarView: TRCalendarView!
    
    func setupWith(trackingDate: NSDate) {
        calendarView = TRCalendarView(trackingDate: trackingDate, withDelegate: self)
        contentView.addSubview(calendarView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.frame = self.bounds
    }
}
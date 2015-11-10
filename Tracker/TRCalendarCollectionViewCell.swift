import UIKit

protocol TRCalendarCollectionViewCellDelegate: class {
    var successDays: [Int] { get }
}

class TRCalendarCollectionViewCell: UICollectionViewCell, TRCalendarViewDelegate {
    var successDays: [Int] {
       return delegate.successDays
    }
    weak var delegate: TRCalendarCollectionViewCellDelegate!
    private var calendarView: TRCalendarView!
    
    func setupWith(trackingDate: NSDate) {
        calendarView = TRCalendarView(trackingDate: trackingDate)
        calendarView.delegate = self
        contentView.addSubview(calendarView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.frame = self.bounds
    }
}
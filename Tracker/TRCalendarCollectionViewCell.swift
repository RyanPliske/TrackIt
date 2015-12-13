import UIKit

protocol TRCalendarCollectionViewCellDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarCollectionViewCell: UICollectionViewCell, TRCalendarViewDelegate {

    weak var delegate: TRCalendarCollectionViewCellDelegate!
    
    private var monthView: TRMonthView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthView.frame = self.bounds
    }
    
    var recordedDays: TRRecordedDays {
        return delegate.recordedDays
    }
    
    func setupWith(trackingDate: NSDate, startColor: UIColor, endColor: UIColor) {
        monthView = TRMonthView(trackingDate: trackingDate, withDelegate: self, startColor: startColor, endColor: endColor)
        contentView.addSubview(monthView)
    }
    
    func redrawGoalSymbols() {
        monthView.redrawGoalSymbols()
    }
}
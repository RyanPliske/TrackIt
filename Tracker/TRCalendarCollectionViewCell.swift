import UIKit

protocol TRCalendarCollectionViewCellDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarCollectionViewCell: UICollectionViewCell, TRCalendarViewDelegate {

    weak var delegate: TRCalendarCollectionViewCellDelegate!
    
    private var monthPresenter: TRMonthPresenter!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        monthView.frame = self.bounds
    }
    
    var recordedDays: TRRecordedDays {
        return delegate.recordedDays
    }
    
    func setupWith(trackingDate: NSDate, startColor: UIColor, endColor: UIColor) {
//        contentView.addSubview(monthView)
    }
    
    func redrawGoalSymbols() {
//        monthView.redrawGoalSymbols()
    }
}
import UIKit

class TRCalendarCollectionViewCell: UICollectionViewCell {
    
    private var calendarView: TRCalendarView!
    
    func setupWith(trackingDate: NSDate) {
        calendarView = TRCalendarView(trackingDate: trackingDate)
        contentView.addSubview(calendarView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.frame = self.bounds
    }
}
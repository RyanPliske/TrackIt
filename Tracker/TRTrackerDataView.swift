import UIKit
import JTCalendar

class TRTrackerDataView: UIView {
    
    let calendarManager: JTCalendarManager
//    let statsView = TRStatsView()
    
    init(frame: CGRect, _calendarManager: JTCalendarManager) {
        calendarManager = _calendarManager
        super.init(frame: frame)
//        statsView.backgroundColor = UIColor.greenColor()
//        addSubview(statsView)
    }

    required init?(coder aDecoder: NSCoder) {
        calendarManager = JTCalendarManager()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let calendarContentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds))
//        statsView.frame = CGRectMake(0, 0, calendarContentSize.width, calendarContentSize.height)
    }
    
}

import UIKit
import JTCalendar

class TRStatsView: UIView {
    
    private let calendarContentView: JTHorizontalCalendarView
    let calendarManager: JTCalendarManager
    
    init(frame: CGRect, _calendarManager: JTCalendarManager) {
        calendarManager = _calendarManager
        calendarContentView = JTHorizontalCalendarView(frame: frame)
        super.init(frame: frame)
        addSubview(calendarContentView)
        calendarManager.contentView = calendarContentView
        calendarManager.setDate(NSDate())
    }

    required init?(coder aDecoder: NSCoder) {
        calendarManager = JTCalendarManager()
        calendarContentView = JTHorizontalCalendarView()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let calendarContentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds) - CGRectGetHeight(self.bounds))
        calendarContentView.frame = CGRectMake(0, 0, calendarContentSize.width, CGRectGetHeight(self.bounds))
    }
    
}

import UIKit
import JTCalendar

class TRStatsView: UIView {
    
    let calendarMenuView: JTCalendarMenuView
    let calendarContentView: JTHorizontalCalendarView
    let calendarManager = JTCalendarManager()
    
    override init(frame: CGRect) {
        calendarMenuView = JTCalendarMenuView(frame: frame)
        calendarContentView = JTHorizontalCalendarView(frame: frame)
        super.init(frame: frame)
        addSubview(calendarMenuView)
        addSubview(calendarContentView)
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        calendarManager.setDate(NSDate())
    }

    required init?(coder aDecoder: NSCoder) {
        calendarMenuView = JTCalendarMenuView()
        calendarContentView = JTHorizontalCalendarView()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let calendarMenuSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds) * 0.2)
        calendarMenuView.frame = CGRectMake(0, 0, calendarMenuSize.width, calendarMenuSize.height)
        let calendarContentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds) - calendarMenuSize.height)
        calendarContentView.frame = CGRectMake(0, calendarMenuSize.height, calendarContentSize.width, calendarContentSize.height)
    }
    
}

import UIKit
import JTCalendar

class TRStatsView: UIView {
    
    private let calendarMenuView: JTCalendarMenuView
    private let calendarContentView: JTHorizontalCalendarView
    let calendarManager: JTCalendarManager
//    var calendarManager: JTCalendarManager? {
//        didSet {
//            self.calendarManager!.menuView = calendarMenuView
//            self.calendarManager!.contentView = calendarContentView
//            self.calendarManager!.setDate(NSDate())
//        }
//    }
    
    init(frame: CGRect, _calendarManager: JTCalendarManager) {
        calendarManager = _calendarManager
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
        calendarManager = JTCalendarManager()
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

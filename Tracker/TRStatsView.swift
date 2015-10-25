import UIKit
import JTCalendar

class TRStatsView: UIView {
    
    let calendarManager: JTCalendarManager
    private let contentView = UIView()
    
    init(frame: CGRect, _calendarManager: JTCalendarManager) {
        calendarManager = _calendarManager
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.greenColor()
        addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        calendarManager = JTCalendarManager()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let calendarContentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds))
        contentView.frame = CGRectMake(0, 0, calendarContentSize.width, calendarContentSize.height)
    }
    
}

import UIKit

protocol TRCalendarViewDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarView: UIView, TRWeekViewDelegate {

    var trackingDate: NSDate!
    var currentDayIndex: Int {
        return TRDateFormatter.dayOfDate(NSDate())
    }
    
    private let titleView = TRCalendarTitleForWeekView()
    private var weekViews = [TRWeekView]()
    private weak var delegate: TRCalendarViewDelegate!
    
    init(trackingDate: NSDate, withDelegate delegate: TRCalendarViewDelegate) {
        self.delegate = delegate
        self.trackingDate = trackingDate
        super.init(frame: CGRectZero)
        
        addSubview(titleView)
        
        let monthGenerator = TRMonthGenerator(trackingDate: trackingDate)
        let weeksOfTheMonth = [monthGenerator.week1, monthGenerator.week2, monthGenerator.week3, monthGenerator.week4, monthGenerator.week5, monthGenerator.week6]
        drawWeeks(weeksOfTheMonth)
        addGoalSymbolForDays(delegate.recordedDays)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var y: CGFloat = 0
        let weekHeight = CGRectGetHeight(self.bounds) / 7
        let weekWidth = CGRectGetWidth(self.bounds)
        
        //layout titles
        titleView.frame = CGRectMake(0, y, weekWidth, weekHeight)
        y += weekHeight
        
        for weekView in weekViews {
            weekView.frame = CGRectMake(0, y, weekWidth, weekHeight)
            y += weekHeight
        }
    }
    
    func redrawGoalSymbols() {
        addGoalSymbolForDays(delegate.recordedDays)
        layoutIfNeeded()
    }
    
    private func drawWeeks(weeksOfTheMonth: [NSArray]) {
        for week in weeksOfTheMonth {
            let weekView = TRWeekView(daysOfTheWeek: week as! [Int], withDelegate: self)
            weekViews.append(weekView)
            addSubview(weekView)
        }
        layoutIfNeeded()
    }
    
    private func addGoalSymbolForDays(recordedDays: TRRecordedDays) {
        for weekView in weekViews {
            for dayView in weekView.dayViews {
                if dayView.dayIndex > currentDayIndex || dayView.dayIndex == 0 {
                    continue
                }
                let matchFound = recordedDays.days.filter { $0 == dayView.dayIndex }.isEmpty
                if recordedDays.dailyGoalType == DailyGoalType.Max {
                    dayView.goalMet = matchFound ? true : false
                } else {
                    dayView.goalMet = matchFound ? false : true
                }
            }
        }

    }
    
}
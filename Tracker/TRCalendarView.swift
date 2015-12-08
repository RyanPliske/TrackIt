import UIKit

protocol TRCalendarViewDelegate: class {
    var recordedDays: TRRecordedDays { get }
}

class TRCalendarView: UIView, TRWeekViewDelegate {
    

    var trackingDate: NSDate!
    var currentDayIndex: Int {
        return TRDateFormatter.dayOfDate(trackingDate)
    }
    
    private let titleView = TRCalendarTitleForWeekView()
    private var weekViews = [TRWeekView]()
    private weak var delegate: TRCalendarViewDelegate!
    private var startColor: UIColor!
    private var endColor: UIColor!
    
    init(trackingDate: NSDate, withDelegate delegate: TRCalendarViewDelegate, startColor: UIColor, endColor: UIColor) {
        self.delegate = delegate
        self.trackingDate = trackingDate
        self.startColor = startColor
        self.endColor = endColor
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
        
        titleView.frame = CGRectMake(0, y, weekWidth, weekHeight)
        y += weekHeight
        
        for weekView in weekViews {
            weekView.frame = CGRectMake(0, y, weekWidth, weekHeight)
            y += weekHeight
        }
    }
    
    override func drawRect(rect: CGRect) {
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let cgGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colors, colorLocations)
        CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), cgGradient, CGPoint.zero, CGPoint(x: 0, y: CGRectGetHeight(bounds)), CGGradientDrawingOptions.DrawsBeforeStartLocation)
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
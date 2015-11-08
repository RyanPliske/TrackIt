import UIKit

class TRCalendarView: UIView {

    var trackingDate: NSDate!
    
    private let successDays = [1, 15, 16, 25]
    private var weekViews = [TRWeekView]()
    
    init(trackingDate: NSDate) {
        self.trackingDate = trackingDate
        super.init(frame: CGRectZero)
        let monthGenerator = TRMonthGenerator(trackingDate: trackingDate)
        let weeksOfTheMonth = [monthGenerator.week1, monthGenerator.week2, monthGenerator.week3, monthGenerator.week4, monthGenerator.week5, monthGenerator.week6]
        drawWeeks(weeksOfTheMonth)
        drawSuccessDays(successDays)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var y: CGFloat = 0
        let weekHeight = CGRectGetHeight(self.bounds) / 6
        let weekWidth = CGRectGetWidth(self.bounds)
        
        for weekView in weekViews {
            weekView.frame = CGRectMake(0, y, weekWidth, weekHeight)
            y += weekHeight
        }
    }
    
    private func drawWeeks(weeksOfTheMonth: [NSArray]) {
        for week in weeksOfTheMonth {
            let weekView = TRWeekView(daysOfTheWeek: week as! [Int])
            weekViews.append(weekView)
            addSubview(weekView)
        }
        layoutIfNeeded()
    }
    
    private func drawSuccessDays(successDays: [Int]) {
        for weekView in weekViews {
            for dayView in weekView.dayViews {
                let success = successDays.filter { $0 == dayView.dayIndex }
                if !success.isEmpty {
                    dayView.goalMet = true
                }
            }
        }

    }
    
}
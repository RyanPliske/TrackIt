import UIKit

class TRCalendarView: UIView {
    
    let week1: [Int] = [1, 2, 3, 4, 5, 6, 7]
    let week2: [Int] = [8, 9, 10, 11, 12, 13, 14]
    let week3: [Int] = [15, 16, 17, 18, 19, 20, 21]
    let week4: [Int] = [22, 23, 24, 25, 26, 27, 28]
    let week5: [Int] = [29, 30]
    let week6: [Int] = []
    var weekViews = [TRWeekView]()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let weeksOfTheMonth = [week1, week2, week3, week4, week5, week6]
        drawWeeks(weeksOfTheMonth)
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
    
}
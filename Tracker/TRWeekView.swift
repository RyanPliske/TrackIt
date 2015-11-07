import UIKit

class TRWeekView: UIView {
    
    var dayViews = [TRDayView]()
    
    init(daysOfTheWeek: [Int]) {
        super.init(frame: CGRectZero)
        drawWeekFor(daysOfTheWeek)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        let dayWidth = CGRectGetWidth(self.bounds) / 7
        let dayHeight = CGRectGetHeight(self.bounds)
        
        for label in dayViews {
            label.frame = CGRectMake(x, 0, dayWidth, dayHeight)
            x += dayWidth
        }
    }
    
    private func drawWeekFor(daysOfThisWeek: [Int]) {
        for dayIndex in daysOfThisWeek {
            let dayView = TRDayView(dayIndex: dayIndex)
            addSubview(dayView)
            dayViews.append(dayView)
        }
    }
    
}
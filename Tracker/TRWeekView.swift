import UIKit

class TRWeekView: UIView {
    
    var daysOfThisWeek = [TRDay]()
    
    private var dayLabels = [TRDayView]()
    
    init(daysOfTheWeek: [Int]) {
        super.init(frame: CGRectZero)
        for day in daysOfTheWeek {
            daysOfThisWeek.append(TRDay(dayIndex: day))
        }
        drawWeek()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawWeek()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        let dayWidth = CGRectGetWidth(self.bounds) / 7
        let dayHeight = CGRectGetHeight(self.bounds)
        
        for label in dayLabels {
            label.frame = CGRectMake(x, 0, dayWidth, dayHeight)
            x += dayWidth
        }
    }
    
    func reDrawWeek() {
        for label in dayLabels {
            label.removeFromSuperview()
        }
        dayLabels.removeAll()
        drawWeek()
    }
    
    
    func drawCheckMarkFor() {
        
    }
    
    
    private func drawWeek() {
        for day in daysOfThisWeek {
            let indexOfDay = day.dayIndex
            let dayView = TRDayView()
            dayView.setDayLabelWith("\(indexOfDay)")
            if day.goalMet {
                dayView.addCheckMark()
            }
            addSubview(dayView)
            dayLabels.append(dayView)
        }
    }
    
}
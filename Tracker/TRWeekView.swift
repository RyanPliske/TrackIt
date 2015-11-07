import UIKit

class TRWeekView: UIView {
    
    var daysOfThisWeek = []
    
    private var dayLabels = [UILabel]()
    
    init(daysOfTheWeek: [Int]) {
        super.init(frame: CGRectZero)
        daysOfThisWeek = daysOfTheWeek
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
    
    private func drawWeek() {
        for indexOfDay in daysOfThisWeek {
            let dayLabel = UILabel()
            dayLabel.textAlignment = NSTextAlignment.Center
            dayLabel.textColor = UIColor.whiteColor()
            dayLabel.text = "\(indexOfDay)"
            addSubview(dayLabel)
            dayLabels.append(dayLabel)
        }
    }
    
}
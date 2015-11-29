import UIKit

class TRCalendarTitleForWeekView: UIView {
    
    private let titleLabels = ["S", "M", "T", "W", "T", "F", "S"]
    
    init() {
        super.init(frame: CGRectZero)
        drawTitleLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        let labelWidth = CGRectGetWidth(self.bounds) / 7
        let labelHeight = CGRectGetHeight(self.bounds)
        
        for label in self.subviews where label is UILabel {
            label.frame = CGRectMake(x, 0, labelWidth, labelHeight)
            x += labelWidth
        }
    }
    
    private func drawTitleLabels() {
        for index in 0...6 {
            let label = UILabel()
            label.text = titleLabels[index]
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            addSubview(label)
        }
    }
    
}
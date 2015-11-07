import UIKit

class TRDayView: UIView {
    
    weak private var goalView: UIView?
    private let dayLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = self.bounds
        goalView?.frame = CGRectMake(CGRectGetMinX(self.bounds) + 7, CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds) - 10, CGRectGetHeight(self.bounds))
    }
    
    func setDayLabelWith(text: String) {
        dayLabel.textAlignment = NSTextAlignment.Center
        dayLabel.textColor = UIColor.whiteColor()
        dayLabel.text = text
        addSubview(dayLabel)
    }
    
    func addCheckMark() {
        if let image = UIImage(named: "checkmark") {
            drawMark(image)
        }
    }
    
    func addXMark() {
        if let image = UIImage(named: "x") {
            drawMark(image)
        }
    }
    
    private func drawMark(markImage: UIImage) {
        let markView = UIImageView(image: markImage)
        markView.alpha = 0.9
        goalView = markView
        insertSubview(goalView!, belowSubview: dayLabel)
    }
    
}
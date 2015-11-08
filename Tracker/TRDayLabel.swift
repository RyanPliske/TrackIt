import UIKit

class TRDayView: UIView {
    
    let dayIndex: Int
    var goalMet = false {
        didSet {
            goalMet ? addCheckMark() : addXMark()
        }
    }
    
    weak private var goalView: UIView?
    private let dayLabel = UILabel()
    
    init(dayIndex: Int) {
        self.dayIndex = dayIndex
        super.init(frame: CGRectZero)
        setDayLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        self.dayIndex = 0
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = self.bounds
        goalView?.frame = CGRectMake(CGRectGetMinX(self.bounds) + 7, CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds) - 10, CGRectGetHeight(self.bounds))
    }
    
    private func addCheckMark() {
        if let image = UIImage(named: "checkmark") {
            drawMark(image)
        }
    }
    
    private func addXMark() {
        if let image = UIImage(named: "x") {
            drawMark(image)
        }
    }
    
    private func drawMark(markImage: UIImage) {
        if goalView != nil {
            goalView!.removeFromSuperview()
            goalView = nil
        }
        let markView = UIImageView(image: markImage)
        markView.alpha = 0.9
        goalView = markView
        insertSubview(goalView!, belowSubview: dayLabel)
    }
    
    private func setDayLabel() {
        dayLabel.textAlignment = NSTextAlignment.Center
        dayLabel.textColor = UIColor.whiteColor()
        if dayIndex != 0 {
            dayLabel.text = "\(dayIndex)"
        }
        addSubview(dayLabel)
    }
    
}
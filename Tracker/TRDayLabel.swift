import UIKit

protocol TRDayViewDelegate: class {
    var currentDayIndex: Int { get }
}

class TRDayView: UIView {
    
    let dayIndex: Int
    var currentDayIndex: Int {
        return delegate.currentDayIndex
    }
    
    var goalMet = false {
        didSet {
            goalMet ? addCheckMark() : addXMark()
        }
    }
    
    private let dayLabel = UILabel()
    private weak var goalView: UIView?
    private weak var delegate: TRDayViewDelegate!
    
    init(dayIndex: Int, withDelegate delegate: TRDayViewDelegate) {
        self.dayIndex = dayIndex
        self.delegate = delegate
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
        dayLabel.textColor = dayIndex <= currentDayIndex ? UIColor.blackColor()  : UIColor.darkGrayColor()
        if dayIndex != 0 {
            dayLabel.text = "\(dayIndex)"
        }
        addSubview(dayLabel)
    }
    
}
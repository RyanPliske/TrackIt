import Foundation
import QuartzCore

class TRTodaysDateButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        
        if let todaysDateLabel = titleLabel {
            todaysDateLabel.font = UIFont(name: "Helvetica", size: 20)
            todaysDateLabel.textColor = UIColor.whiteColor()
            todaysDateLabel.textAlignment = NSTextAlignment.Center
        }
    }
}
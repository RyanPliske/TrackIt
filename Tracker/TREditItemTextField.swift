import UIKit
import QuartzCore

class TREditItemTextField: UITextField {

    private var edgeInsets = UIEdgeInsetsMake(1.0, 10.0, 1.0, 10.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.darkGrayColor().CGColor
        layer.borderWidth = 1.0
        
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, edgeInsets))
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return super.editingRectForBounds(UIEdgeInsetsInsetRect(bounds, edgeInsets))
    }
    
}

import UIKit

class TRTrackerView: UIView {
    var dateTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dateTextField = UITextField(frame: CGRectMake(0, 50, 300, 50))
        dateTextField.backgroundColor = UIColor.blackColor()
        dateTextField.textColor = UIColor.whiteColor()
        dateTextField.textAlignment = NSTextAlignment.Center
        dateTextField.layer.borderColor = UIColor.whiteColor().CGColor
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.cornerRadius = 8.0
        dateTextField.layer.masksToBounds = true
        dateTextField.valueForKey("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
        self.addSubview(self.dateTextField)
    }
    
    func setDateTextFieldTextWith(text : String) {
        dateTextField.text = text
    }
}

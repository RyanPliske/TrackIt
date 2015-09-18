import Foundation

protocol TRKeyboardToolbarDelegate {
    func TRKeyboardToolbarDone()
    func TRKeyboardToolbarCanceled()
}

class TRKeyboardToolbar: UIToolbar {
    
    var toolbarDelegate: TRKeyboardToolbarDelegate?
    
    init() {
        super.init(frame: CGRectZero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        sizeToFit()
        barStyle = UIBarStyle.Black
        tintColor = UIColor.TRBabyBlue()
        let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneTapped")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelTapped")
        setItems([cancelButton, flexibleSpace, doneButton], animated: false)
    }
    
    func doneTapped() {
        toolbarDelegate?.TRKeyboardToolbarDone()
    }
    
    func cancelTapped() {
        toolbarDelegate?.TRKeyboardToolbarCanceled()
    }
}
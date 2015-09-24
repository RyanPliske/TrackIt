import Foundation

class TRTrackerTableViewCellWithTextField: TRTrackerTableViewCell, UITextFieldDelegate, TRKeyboardToolbarDelegate {
    
    @IBOutlet private weak var itemCountTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCountTextField.delegate = self
        let keyboardInputAccessoryView = TRKeyboardToolbar()
        keyboardInputAccessoryView.toolbarDelegate = self
        itemCountTextField.inputAccessoryView = keyboardInputAccessoryView
    }
    
    func setTextFieldPlaceHolder(text: String) {
        itemCountTextField.placeholder = text
    }
        
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    // TRKeyboardToolbarDelegate
    func TRKeyboardToolbarCanceled() {
        itemCountTextField.resignFirstResponder()
    }
    
    func TRKeyboardToolbarDone() {
        itemCountTextField.resignFirstResponder()
        delegate?.textFieldReturnedWithTextAtRow(self.tag, text: itemCountTextField.text!)
        itemCountTextField.text = nil
    }
}
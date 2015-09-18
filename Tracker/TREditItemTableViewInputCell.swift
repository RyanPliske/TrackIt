import UIKit

protocol TREditItemTableViewInputCellDelegate {
    func textFieldChangedAtRow(row: Int, text: String)
}

class TREditItemTableViewInputCell: TRSettingsTableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!{
        didSet {
            textField?.delegate = self
        }
    }
    var textFieldDelegate: TREditItemTableViewInputCellDelegate?
    var skipDelegating = false
    var storedText: String?
    
    func setLabelWithText(text: String) {
        itemLabel?.text = text
    }
    
    func setTextFieldTextWithText(text: String) {
        textField?.text = text
        storedText = text
    }
    
    func setTextFieldTagWith(tag: Int) {
        textField?.tag = tag
    }
    
    func setTextFieldAsFirstResponder() {
        textField?.becomeFirstResponder()
    }
    
    func setTextFieldUserInteraction(enabled: Bool) {
        textField?.userInteractionEnabled = enabled
    }
    
    func setTextFieldKeyboardTypeToNumberPad() {
        textField?.keyboardType = UIKeyboardType.NumberPad
        let doneButtonView = UIToolbar()
        doneButtonView.sizeToFit()
        doneButtonView.barStyle = UIBarStyle.Black
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneTapped")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelTapped")
        doneButtonView.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        textField?.inputAccessoryView = doneButtonView
    }
    
    func doneTapped() {
        textField?.resignFirstResponder()
    }
    
    func cancelTapped() {
        skipDelegating = true
        textField?.resignFirstResponder()
        textField?.text = storedText
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        if skipDelegating {
            skipDelegating = false
            return
        }
        textField.resignFirstResponder()
        textFieldDelegate?.textFieldChangedAtRow(textField.tag, text: textField.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

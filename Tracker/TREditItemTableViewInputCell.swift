import UIKit

protocol TREditItemTableViewInputCellDelegate: TREditItemTableViewInputGoalCellDelegate {
    func textFieldChangedAtRow(row: Int, text: String)
}

class TREditItemTableViewInputCell: TRSettingsTableViewCell, UITextFieldDelegate, TRKeyboardToolbarDelegate {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet weak var textField: UITextField!{
        didSet {
            textField?.delegate = self
        }
    }
    weak var cellDelegate: TREditItemTableViewInputCellDelegate!
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
        textField?.alpha = enabled ? 1.0 : 0.5
        itemLabel?.alpha = enabled ? 1.0 : 0.5
    }
    
    func setTextFieldKeyboardTypeToNumberPad() {
        textField?.keyboardType = UIKeyboardType.NumberPad
        let doneToolbarView = TRKeyboardToolbar()
        doneToolbarView.toolbarDelegate = self
        textField?.inputAccessoryView = doneToolbarView
    }
    
    func TRKeyboardToolbarDone() {
        textField?.resignFirstResponder()
    }
    
    func TRKeyboardToolbarCanceled() {
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
        cellDelegate.textFieldChangedAtRow(textField.tag, text: textField.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

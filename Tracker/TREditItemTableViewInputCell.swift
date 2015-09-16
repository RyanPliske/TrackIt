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
    
    func setLabelWithText(text: String) {
        itemLabel?.text = text
    }
    
    func setTextFieldTextWithText(text: String) {
        textField?.text = text
    }
    
    func setTextFieldTagWith(tag: Int) {
        textField?.tag = tag
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldDelegate?.textFieldChangedAtRow(textField.tag, text: textField.text!)
        return true
    }
    
}

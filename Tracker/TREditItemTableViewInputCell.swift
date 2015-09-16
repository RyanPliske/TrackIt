import UIKit

protocol TREditItemTableViewInputCellDelegate {
    func textFieldReturnedAtRow(row: Int, text: String)
}

class TREditItemTableViewInputCell: TRSettingsTableViewCell, UITextFieldDelegate {
    
    @IBOutlet private var itemLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    var textFieldDelegate: TREditItemTableViewInputCellDelegate?
    
    override func layoutSubviews() {
        textField?.delegate = self
    }
    
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
        textFieldDelegate?.textFieldReturnedAtRow(textField.tag, text: textField.text!)
        return true
    }
    
}

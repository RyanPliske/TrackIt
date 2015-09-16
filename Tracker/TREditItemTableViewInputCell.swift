import UIKit

class TREditItemTableViewInputCell: TRSettingsTableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    override func layoutSubviews() {
        textField?.delegate = self
    }
    
    func setLabelWithText(text: String) {
        itemLabel?.text = text
    }
    
    func setTextFieldTextWithText(text: String) {
        textField?.text = text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

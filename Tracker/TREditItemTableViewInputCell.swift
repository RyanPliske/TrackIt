import UIKit

class TREditItemTableViewInputCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    func setLabelWithText(text: String) {
        itemLabel?.text = text
    }
    
    func setTextFieldTextWithText(text: String) {
        textField?.text = text
    }
    
}

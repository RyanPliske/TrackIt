import UIKit

class TREditItemTableViewCell: TRSettingsTableViewCell {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    func setLabelWithText(text: String) {
        itemLabel?.text = text
    }
    
}

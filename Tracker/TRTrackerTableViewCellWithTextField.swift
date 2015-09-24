import Foundation

class TRTrackerTableViewCellWithTextField: TRTrackerTableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var itemCountTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCountTextField.delegate = self
    }
    
    func setTextFieldPlaceHolder(text: String) {
        itemCountTextField.placeholder = text
    }
        
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
}
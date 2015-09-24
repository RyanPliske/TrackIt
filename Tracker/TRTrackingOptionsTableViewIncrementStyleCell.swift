import Foundation

class TRTrackingOptionsTableViewIncrementStyleCell: UITableViewCell {
    @IBOutlet private weak var trackIncrementStyleLabel: UILabel!
    
    func setIncrementLabel(text: String) {
        trackIncrementStyleLabel?.text = text
    }
}
import Foundation

class TRTrackerTableViewCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    
    func setItemLabelTextWith(itemName: String) {
        self.itemLabel.text = itemName
    }
    
}

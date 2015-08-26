import UIKit

class TREditTracksTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setItemLabelTextWith(text: String) {
        if let item = itemLabel {
            item.text = text
        }
    }
    
    func setCountLabelTextWith(text: String) {
        if let count = countLabel {
            count.text = text
        }
    }
    
    func setDateLabelTextWith(text: String) {
        if let date = dateLabel {
            date.text = text
        }
    }
    
}

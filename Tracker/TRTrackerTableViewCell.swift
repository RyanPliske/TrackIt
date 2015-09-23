import Foundation
import Spring

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAt(row: Int)
}

class TRTrackerTableViewCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var plusButton: SpringButton!
    var statsView: UIView?
    var delegate: TRTrackerTableViewCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        statsView = UIView(frame: CGRectMake(0, 60, CGRectGetWidth(self.bounds), 330))
        statsView!.backgroundColor = UIColor.greenColor()
        addSubview(statsView!)
    }
    
    func setItemLabelTextWith(itemName: String) {
        self.itemLabel.attributedText = NSAttributedString(string: itemName.uppercaseString, attributes: [NSKernAttributeName: 1.7])
    }
    
    func setTagsForCellWith(tag: Int) {
        self.plusButton.tag = tag
    }
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        self.delegate?.plusButtonPressedAt(plusButton.tag)
        plusButton.animation = "pop"
        plusButton.force = 5.0
        plusButton.animate()
    }
}

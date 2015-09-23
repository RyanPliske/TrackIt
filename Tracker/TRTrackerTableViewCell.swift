import Foundation
import Spring

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int)
}

class TRTrackerTableViewCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var plusButton: SpringButton!
    @IBOutlet private weak var moreButton: UIButton!
    
    var statsView: UIView?
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
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
        self.delegate?.plusButtonPressedAtRow(plusButton.tag)
        plusButton.animation = "pop"
        plusButton.force = 5.0
        plusButton.animate()
    }
    
    @IBAction func moreButtonPressed(sender: AnyObject) {
        self.delegate?.moreButtonPressedAtRow(plusButton.tag)
    }
    
}

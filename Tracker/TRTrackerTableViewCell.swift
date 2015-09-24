import Foundation

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool)
    func trackUrgeSelectedForRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
}

class TRTrackerTableViewCell: UITableViewCell, TRTrackingOptionsDelegate {
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    private var statsView: UIView?
    private var isAVice = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        statsView = UIView(frame: CGRectMake(0, 60, CGRectGetWidth(self.bounds), 330))
        statsView!.backgroundColor = UIColor.greenColor()
        addSubview(statsView!)
    }
    
    func setItemLabelTextWith(itemName: String) {
        itemLabel.attributedText = NSAttributedString(string: itemName.uppercaseString, attributes: [NSKernAttributeName: 1.7])
    }
    
    func setTagsForCellWith(tag: Int) {
        self.tag = tag
    }
    
    func setCellAsBadHabit(isAVice: Bool) {
        self.isAVice = isAVice
    }
    
    @IBAction func moreButtonPressed(sender: AnyObject) {
        delegate?.moreButtonPressedAtRow(self.tag, includeBadHabit: isAVice)
    }
    
    // MARK: TRTrackingOptionsDelegate
    func trackUrge() {
        delegate?.trackUrgeSelectedForRow(self.tag)
    }
    
    func trackMultiple() {
        delegate?.trackMultipleSelectedForRow(self.tag)
    }
    
}

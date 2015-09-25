import Foundation

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool)
    func trackUrgeSelectedForRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String)
}

class TRTrackerTableViewCell: UITableViewCell, TRTrackingOptionsDelegate {
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    private var statsView: UIView
    private var isAVice = false
    
    required init?(coder aDecoder: NSCoder) {
        statsView = UIView()
        statsView.backgroundColor = UIColor.greenColor()
        super.init(coder: aDecoder)
        addSubview(statsView)
    }
    
    override func layoutSubviews() {
        statsView.frame = CGRectMake(0, 60, CGRectGetWidth(self.bounds), UIScreen.mainScreen().applicationFrame.size.height - 200)
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

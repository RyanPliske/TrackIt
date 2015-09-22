import Foundation

class TRTrackerTableViewCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    var statsView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        statsView = UIView(frame: CGRectMake(0, 60, CGRectGetWidth(self.bounds), 330))
        statsView!.backgroundColor = UIColor.greenColor()
        addSubview(statsView!)
    }
    
    func setItemLabelTextWith(itemName: String) {
        self.itemLabel.attributedText = NSAttributedString(string: itemName.uppercaseString, attributes: [NSKernAttributeName: 1.7])
    }
    
}

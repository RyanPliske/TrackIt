import Foundation
import JTCalendar
import Spring

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool)
    func trackUrgeSelectedForRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String)
}

class TRTrackerTableViewCell: UITableViewCell {
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var itemCountLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    private var statsView: TRStatsView? 
    private var isAVice = false

    var selectedDatesOnJTCalendar = [String]()
    var dateSelectedOnJTCalendar: NSDate!
    
    override func layoutSubviews() {
        statsView?.frame = CGRectMake(0, TRTrackerTableViewCellSize.closedHeight, CGRectGetWidth(self.bounds), TRTrackerTableViewCellSize.openedHeight - TRTrackerTableViewCellSize.closedHeight)
    }
    
    func prepareStatsView() {
        if statsView == nil {
            statsView = TRStatsView(frame: CGRectZero, trackingDate: dateSelectedOnJTCalendar)
            addSubview(statsView!)
            layoutIfNeeded()
        }
    }
    
    func destroyStatsView() {
        if statsView != nil {
            statsView!.removeFromSuperview()
            statsView = nil
        }
    }
    
    func updateItemLabelCountWith(newItemCount: Float) {
        if let currentCount = Float(itemCountLabel.text!) {
            let totalCount = currentCount + newItemCount
            itemCountLabel.text = newItemCount % 1  == 0 ? Int(totalCount).description : totalCount.description
        }
    }
    
    func setItemLabelCountWith(itemCount: Float) {
        itemCountLabel.text = itemCount % 1  == 0 ? Int(itemCount).description : itemCount.description
    }
    
    func setItemNameLabelTextWith(itemName: String) {
        itemLabel.attributedText = NSAttributedString(string: itemName.uppercaseString, attributes: [NSKernAttributeName: 1.7])
    }
    
    func setTagsForCellWith(tag: Int) {
        self.tag = tag
    }
    
    func setCellAsBadHabit(isAVice: Bool) {
        self.isAVice = isAVice
    }
    
    func resetCalendar() {
        selectedDatesOnJTCalendar.removeAll()
    }
    
    func resetCalendarAfterTrackOccured() {
        if let dateSelected = dateSelectedOnJTCalendar {
            selectedDatesOnJTCalendar.append(TRDateFormatter.descriptionForDate(dateSelected))
        }
    }
    
    func setWhiteDotsOnDatesWith(dates: [String]) {
        selectedDatesOnJTCalendar = dates
        print(selectedDatesOnJTCalendar)
    }
    
    func setSelectedDateOnCalendarWith(selectedDate: NSDate) {
        dateSelectedOnJTCalendar = selectedDate
    }
    
    @IBAction func moreButtonPressed(sender: AnyObject) {
        delegate?.moreButtonPressedAtRow(self.tag, includeBadHabit: isAVice)
    }
}

extension TRTrackerTableViewCell: TRTrackingOptionsDelegate {
    func trackUrge() {
        delegate?.trackUrgeSelectedForRow(self.tag)
    }
    
    func trackMultiple() {
        delegate?.trackMultipleSelectedForRow(self.tag)
    }
}
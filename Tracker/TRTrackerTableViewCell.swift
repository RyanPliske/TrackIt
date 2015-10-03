import Foundation
import JTCalendar

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool)
    func trackUrgeSelectedForRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String)
    func calendarDateSelected(date: NSDate)
}

class TRTrackerTableViewCell: UITableViewCell, TRTrackingOptionsDelegate {
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    private var statsView: TRStatsView
    private var isAVice = false
    typealias itemLabelDescription = (name: String, count: Float)
    var label: itemLabelDescription = ("", 0.0)
    let calendarManager = JTCalendarManager()
    var selectedDatesOnJTCalendar = [String]()
    var dateSelectedOnJTCalendar: NSDate?
    
    required init?(coder aDecoder: NSCoder) {
        self.statsView = TRStatsView(frame: CGRectZero, _calendarManager: calendarManager)
        super.init(coder: aDecoder)
        self.calendarManager.delegate = self
        addSubview(statsView)
    }
    
    override func layoutSubviews() {
        statsView.frame = CGRectMake(0, 60, CGRectGetWidth(self.bounds), UIScreen.mainScreen().applicationFrame.size.height - 200)
    }
    
    func setItemLabelTextWith(itemName: String, itemCount: Float) {
        
        self.label = (itemName, itemCount)
        let text = NSMutableAttributedString()
        let attributes = [NSKernAttributeName: 1.7]
        
        let itemNameAttributed = NSMutableAttributedString(string: itemName.uppercaseString, attributes: attributes)
        text.appendAttributedString(itemNameAttributed)
        
        let itemCountAttributed: NSMutableAttributedString
        if itemCount % 1  == 0 {
            itemCountAttributed = NSMutableAttributedString(string: ": " + Int(itemCount).description, attributes: attributes)
        } else {
            itemCountAttributed = NSMutableAttributedString(string: ": " + itemCount.description, attributes: attributes)
        }
        text.appendAttributedString(itemCountAttributed)
        
        itemLabel.attributedText = text
    }
    
    func setTagsForCellWith(tag: Int) {
        self.tag = tag
    }
    
    func setCellAsBadHabit(isAVice: Bool) {
        self.isAVice = isAVice
    }
    
    func resetCalendar() {
        selectedDatesOnJTCalendar.removeAll()
        calendarManager.reload()
    }
    
    func resetCalendarAfterTrackOccured() {
        if let dateSelected = dateSelectedOnJTCalendar {
            selectedDatesOnJTCalendar.append(TRDateFormatter.descriptionForDate(dateSelected))
        }
        calendarManager.reload()
    }
    
    func setWhiteDotsOnDatesWith(dates: [String]) {
        selectedDatesOnJTCalendar = dates
        print(selectedDatesOnJTCalendar)
        calendarManager.reload()
    }
    
    func setSelectedDateOnCalendarWith(selectedDate: NSDate) {
        dateSelectedOnJTCalendar = selectedDate
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

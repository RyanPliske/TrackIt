import Foundation
import JTCalendar
import Spring

protocol TRTrackerTableViewCellDelegate {
    func plusButtonPressedAtRow(row: Int)
    func moreButtonPressedAtRow(row: Int, includeBadHabit: Bool)
    func trackUrgeSelectedForRow(row: Int)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String)
    func calendarDateSelected(date: NSDate)
}

class TRTrackerTableViewCell: UITableViewCell {
    var delegate: TRTrackerTableViewCellDelegate?
    var moreButtonFrame: CGRect {
        return self.moreButton.frame
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var itemCountLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    private var statsView: TRStatsView
    private var isAVice = false
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
}

extension TRTrackerTableViewCell: TRTrackingOptionsDelegate {
    func trackUrge() {
        delegate?.trackUrgeSelectedForRow(self.tag)
    }
    
    func trackMultiple() {
        delegate?.trackMultipleSelectedForRow(self.tag)
    }
}

extension TRTrackerTableViewCell: JTCalendarDelegate {
    
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        if let aDayView = dayView as? JTCalendarDayView {
            dateSelectedOnJTCalendar = aDayView.date
            delegate?.calendarDateSelected(dateSelectedOnJTCalendar!)
            aDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
            UIView.transitionWithView(aDayView, duration: 0.3, options: .CurveEaseIn, animations: { () -> Void in
                aDayView.circleView.transform = CGAffineTransformIdentity
                self.calendarManager.reload()
                }, completion: nil)
        }
    }
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let aDayView = dayView as? JTCalendarDayView {
            //Dot View
            if dateIsIncluded(TRDateFormatter.descriptionForDate(aDayView.date)) {
                aDayView.dotView.hidden = false
                aDayView.dotView.backgroundColor = UIColor.whiteColor()
            } else {
                aDayView.dotView.hidden = true
            }
            // Blue Circle View
            if let selectedDate = dateSelectedOnJTCalendar where calendar.dateHelper.date(selectedDate, isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.whiteColor()
                aDayView.textLabel.textColor = UIColor.TRBabyBlue()
                aDayView.dotView.backgroundColor = UIColor.TRBabyBlue()
            }
                // White Circle View for today
            else if calendar.dateHelper.date(NSDate(), isTheSameDayThan: aDayView.date) {
                aDayView.circleView.hidden = false
                aDayView.circleView.backgroundColor = UIColor.TRBabyBlue()
                aDayView.textLabel.textColor = UIColor.whiteColor()
                aDayView.dotView.backgroundColor = UIColor.whiteColor()
            }
            else {
                aDayView.circleView.hidden = true
                aDayView.textLabel.textColor = UIColor.blackColor()
            }
            
            aDayView.hidden = aDayView.isFromAnotherMonth ? true : false
            
        }
    }
    
    private func dateIsIncluded(date: String) -> Bool {
        let dates = selectedDatesOnJTCalendar.filter { $0 == date }
        return dates.isEmpty ? false : true
    }
}
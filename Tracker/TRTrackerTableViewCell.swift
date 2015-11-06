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
    var dateSelectedOnJTCalendar: NSDate?
    
    override func layoutSubviews() {
        statsView?.frame = CGRectMake(0, TRTrackerTableViewCellSize.closedHeight, CGRectGetWidth(self.bounds), TRTrackerTableViewCellSize.openedHeight - TRTrackerTableViewCellSize.closedHeight)
    }
    
    func prepareStatsView() {
        if statsView == nil {
            statsView = TRStatsView(frame: CGRectZero)
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

extension TRTrackerTableViewCell: JTCalendarDelegate {
    
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
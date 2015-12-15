import UIKit
import TPKeyboardAvoiding
import Spring

protocol TRTrackerViewDelegate: class, TRTrackerTableViewCellDelegate {
    func itemSelectedAtRow(row: Int)
    func itemAtRowIsOpened(row:Int) -> Bool
}

protocol TRTrackerViewObserver {

}

class TRTrackerView: UIView, TRTrackerTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var todaysDateButton: UIButton!
    @IBOutlet weak var recordSavedLabel: SpringLabel!
    @IBOutlet weak var trackerTableView: TPKeyboardAvoidingTableView! {
        didSet {
            self.trackerTableView.delegate = self
        }
    }

    var delegate: TRTrackerViewDelegate!
    var observer: TRTrackerViewObserver?
    var animations = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTodaysDateButtonLabelWithText(TRDateFormatter.descriptionForToday)
        trackerTableView.showsVerticalScrollIndicator = false
    }
    
    func setTodaysDateButtonLabelWithText(text: String) {
        todaysDateButton.setTitle(text, forState: UIControlState.Normal)
    }
    
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    private func animateSavedRecordForRow(row: Int) {
        weak var weakSelf = self
        recordSavedLabel.hidden = false
        
        let animationIndex = animations.count
        animations.append(animationIndex)
        
        func zoomOut() {
            if weakSelf?.animations.count > 0 {
                if (weakSelf?.animations.count)! - 1 == (weakSelf?.animations[animationIndex])! {
                    weakSelf?.recordSavedLabel.animation = "zoomOut"
                    weakSelf?.recordSavedLabel.force = 1.0
                    weakSelf?.animations.removeAll()
                    weakSelf?.recordSavedLabel.animate()
                }
            }
        }
        
        recordSavedLabel.textColor = TRColorGenerator.colorFor(row)
        recordSavedLabel.animation = "fadeInDown"
        recordSavedLabel.curve = "easeIn"
        recordSavedLabel.force = 0.1
        recordSavedLabel.animateNext { () -> () in
            weakSelf?.delay(1.5, closure: zoomOut)
        }
    }
    
    // MARK: TRTrackerPresenter Calls
    
    func itemOpenedStatusChangedAtIndex(index: Int) {
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        trackerTableView.beginUpdates()
        trackerTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        trackerTableView.endUpdates()
        trackerTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    // MARK: TRTrackerTableViewCellDelegate
    
    func plusButtonPressedAtRow(row: Int, completion: TRCreateRecordCompletion) {
        delegate.plusButtonPressedAtRow(row) { () -> Void in
            completion()
        }
        animateSavedRecordForRow(row)
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String, completion: TRCreateRecordCompletion) {
        delegate.textFieldReturnedWithTextAtRow(row, text: text) { () -> Void in
            completion()
        }
        animateSavedRecordForRow(row)
    }
    
    func recordedMonthlyTracksForRow(row: Int) -> TRTracks {
        return delegate.recordedMonthlyTracksForRow(row)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return itemsModel.activeItems.count
        return 21
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let item = itemsModel.activeItems[indexPath.section]
//        var cell: TRTrackerTableViewCell
//        if item.incrementByOne {
//            cell = tableView.dequeueReusableCellWithIdentifier("itemWithPlusButton") as! TRTrackerTableViewCellWithPlusButton
//        } else {
//            let aCell = tableView.dequeueReusableCellWithIdentifier("itemWithTextField") as! TRTrackerTableViewCellWithTextField
//            let placeHolder = item.measurementUnit == "none" ? item.name : item.measurementUnit
//            aCell.setTextFieldPlaceHolder(placeHolder)
//            cell = aCell
//        }
//        setLabelTextWithItem(item, cell: cell)
//        cell.setTagsForCellWith(indexPath.section)
//        cell.delegate = trackerView
//        cell.backgroundColor = TRColorGenerator.colorFor(indexPath.section)
//        cell.setSelectedDateOnCalendarWith(dateToTrack)
//        if item.opened {
//            cell.destroyStatsView()
//            cell.prepareStatsView()
//        } else {
//            cell.destroyStatsView()
//        }
//        return cell
        return tableView.dequeueReusableCellWithIdentifier("itemWithPlusButton") as! TRTrackerTableViewCellWithPlusButton
    }
    
//    private func setLabelTextWithItem(item: TRItem, cell: TRTrackerTableViewCell) {
//        cell.setItemNameLabelTextWith(item.name + ":")
//        recordsModel.searchRecordsForItem(item.name, dateDescription: TRDateFormatter.descriptionForDate(dateToTrack)) { (records, error) -> Void in
//            if let returnedRecords = records {
//                let itemCounts: [Float] = returnedRecords.map { $0.itemQuantity }
//                let itemCountSum: Float = itemCounts.reduce(0) { $0 + $1 }
//                cell.setItemLabelCountWith(itemCountSum)
//            }
//        }
//    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.sizeToFit()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if delegate.itemAtRowIsOpened(indexPath.section) {
            return TRTrackerTableViewCellSize.openedHeight
        }
        return TRTrackerTableViewCellSize.closedHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.itemSelectedAtRow(indexPath.section)
    }
    
}

import Foundation
import Spring

protocol TRTrackerTableViewCellDelegate: class {
    func plusButtonPressedAtRow(row: Int, completion: TRCreateRecordCompletion)
    func trackUrgeSelectedForRow(row: Int, completion: TRCreateRecordCompletion)
    func trackMultipleSelectedForRow(row: Int)
    func textFieldReturnedWithTextAtRow(row: Int, text: String, completion: TRCreateRecordCompletion)
    func recordedMonthlyTracksForRow(row: Int) -> TRTracks
}

class TRTrackerTableViewCell: UITableViewCell, TRStatsModelDelegate {
    
    weak var delegate: TRTrackerTableViewCellDelegate!
    var dateToTrack: NSDate!
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var itemCountLabel: UILabel!
    private var statsPresenter: TRStatsPresenter!
    private var statsModel: TRStatsModel!
    private var isAVice = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        statsPresenter?.statsView.frame = CGRectMake(0, TRTrackerTableViewCellSize.closedHeight, CGRectGetWidth(self.bounds), TRTrackerTableViewCellSize.openedHeight - TRTrackerTableViewCellSize.closedHeight)
    }

    var recordedTracksForTheMonth: TRTracks {
        return delegate.recordedMonthlyTracksForRow(self.tag)
    }
    
    var dailyGoalType: DailyGoalType {
        return TRItemsModel.sharedInstanceOfItemsModel.activeItems[tag].dailyGoalType
    }
    
    var dailyGoal: Int {
        return TRItemsModel.sharedInstanceOfItemsModel.activeItems[tag].dailyGoal!
    }
    
    var trackingDate: NSDate {
        return dateToTrack
    }
    
    func prepareStatsView() {
        if statsPresenter == nil {
            statsModel = TRStatsModel(withDelegate: self)
            statsPresenter = TRStatsPresenter(withStatsModel: statsModel)
            statsPresenter.statsView = TRStatsView(frame: CGRectZero, trackingDate: dateToTrack, delegate: statsPresenter)
            addSubview(statsPresenter.statsView)
            layoutIfNeeded()
        }
    }
    
    func destroyStatsView() {
        if statsPresenter != nil {
            statsPresenter.statsView.removeFromSuperview()
            statsPresenter = nil
            statsModel = nil
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
    
    func resetCalendarAfterTrackOccured() {
        let item = TRItemsModel.sharedInstanceOfItemsModel.activeItems[tag]
        if item.dailyGoal != nil {
            if let cell = statsPresenter.statsView.collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? TRCalendarCollectionViewCell {
                cell.redrawGoalSymbols()
            }
        }
        if let cell = statsPresenter.statsView.collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? TRGraphCollectionViewCell {
            cell.reset()
        }
    }
    
    func setSelectedDateOnCalendarWith(selectedDate: NSDate) {
        dateToTrack = selectedDate
    }
}

extension TRTrackerTableViewCell: TRTrackingOptionsDelegate {
    func trackUrge() {
        delegate.trackUrgeSelectedForRow(self.tag) { [weak self]() -> Void in
            self?.resetCalendarAfterTrackOccured()
        }
    }
    
    func trackMultiple() {
        delegate.trackMultipleSelectedForRow(self.tag)
    }
}
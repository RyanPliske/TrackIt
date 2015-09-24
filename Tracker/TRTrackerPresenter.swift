import Foundation

class TRTrackerPresenter: NSObject, TRTrackerViewDelegate, UITableViewDataSource {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    private lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
    var dateToTrack = NSDate()
    var trackingType : TRRecordType = .TrackAction

    
    init(view: TRTrackerView, model: TRRecordsModel) {
        trackerView = view
        recordsModel = model
        super.init()
        self.trackerView.delegate = self
        self.trackerView.trackerTableView.dataSource = self
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemsModel.activeItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = itemsModel.activeItems[indexPath.section]
        var cell: TRTrackerTableViewCell
        if item.incrementByOne {
            let aCell = tableView.dequeueReusableCellWithIdentifier("itemWithTextField") as! TRTrackerTableViewCellWithTextField
            let placeHolder = item.measurementUnit == "none" ? item.name : item.measurementUnit
            aCell.setTextFieldPlaceHolder(placeHolder)
            cell = aCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("itemWithPlusButton") as! TRTrackerTableViewCellWithPlusButton
        }
        cell.setItemLabelTextWith(itemsModel.activeItems[indexPath.section].name)
        cell.setCellAsBadHabit(itemsModel.activeItems[indexPath.section].isAVice)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRCellColorGenerator.colorFor(indexPath.section)
        return cell
    }
    
    // MARK: TRTrackerViewDelegate
    
    func trackItemAtRow(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackAction, date: dateToTrack)
    }
    
    func trackUrgeAtRow(row: Int) {
        recordsModel.createRecordUsingRow(row, quantity: 1, type: TRRecordType.TrackUrge, date: dateToTrack)
    }
    
    func textFieldReturnedWithTextAtRow(row: Int, text: String) {
        if !text.isEmpty {
            let quantityFromTextField = Float(text)
        recordsModel.createRecordUsingRow(row, quantity: quantityFromTextField!, type: TRRecordType.TrackAction, date: dateToTrack)
        }
    }
    
    func trackMultipleSelectedForRow(row: Int) {
        itemsModel.updateItemIncrementalStatusAtIndex(row)
        if itemsModel.activeItems[row].incrementByOne {
            trackerView.trackerTableView.reloadSections(NSIndexSet(index: row), withRowAnimation: UITableViewRowAnimation.Left)
        } else {
            trackerView.trackerTableView.reloadSections(NSIndexSet(index: row), withRowAnimation: UITableViewRowAnimation.Right)
        }
    }
    
}

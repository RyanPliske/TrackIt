import Foundation
import JTCalendar

class TRTrackerPresenter: NSObject, UITableViewDataSource {
    let trackerView: TRTrackerView
    let recordsModel: TRRecordsModel
    lazy var itemsModel = TRItemsModel.sharedInstanceOfItemsModel
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
            cell = tableView.dequeueReusableCellWithIdentifier("itemWithPlusButton") as! TRTrackerTableViewCellWithPlusButton
        } else {
            let aCell = tableView.dequeueReusableCellWithIdentifier("itemWithTextField") as! TRTrackerTableViewCellWithTextField
            let placeHolder = item.measurementUnit == "none" ? item.name : item.measurementUnit
            aCell.setTextFieldPlaceHolder(placeHolder)
            cell = aCell
        }
        cell.setItemLabelTextWith(itemsModel.activeItems[indexPath.section].name)
        cell.setCellAsBadHabit(itemsModel.activeItems[indexPath.section].isAVice)
        cell.setTagsForCellWith(indexPath.section)
        cell.delegate = trackerView
        cell.backgroundColor = TRColorGenerator.colorFor(indexPath.section)
        return cell
    }
    
}
